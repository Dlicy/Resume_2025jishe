package com.example.computerdesign.Service;

import com.example.computerdesign.DTO.BookDTO;
import com.example.computerdesign.DTO.BookResponseDTO;
import com.example.computerdesign.DAO.Book;
import com.example.computerdesign.Utils.FileStorageService;
import com.example.computerdesign.config.AppConfig;
import com.example.computerdesign.exception.ResourceNotFoundException;
import com.example.computerdesign.DAO.BookRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final ModelMapper modelMapper;
    private final FileStorageService fileStorageService;
    private final AppConfig appConfig;

    @Autowired
    public BookService(BookRepository bookRepository,
                       ModelMapper modelMapper,
                       FileStorageService fileStorageService,
                       AppConfig appConfig) {
        this.bookRepository = bookRepository;
        this.modelMapper = modelMapper;
        this.fileStorageService = fileStorageService;
        this.appConfig = appConfig;
    }

    @Transactional
    public BookResponseDTO addBook(BookDTO bookDTO) {
        Book book = modelMapper.map(bookDTO, Book.class);

        // Handle file uploads
        if (bookDTO.getBookFile() != null && !bookDTO.getBookFile().isEmpty()) {
            String filePath = fileStorageService.storeFile(bookDTO.getBookFile(), "books");
            book.setFilePath(filePath);
            book.setFileType(getFileType(bookDTO.getBookFile().getOriginalFilename()));
        }

        if (bookDTO.getCoverImage() != null && !bookDTO.getCoverImage().isEmpty()) {
            String coverPath = fileStorageService.storeFile(bookDTO.getCoverImage(), "covers");
            book.setCoverPath(coverPath);
        }

        Book savedBook = bookRepository.save(book);
        return convertToResponseDTO(savedBook);
    }

    public Page<BookResponseDTO> getAllBooks(Pageable pageable, String searchQuery) {
        Specification<Book> spec = Specification.where(null);

        if (searchQuery != null && !searchQuery.isEmpty()) {
            spec = spec.and((root, query, cb) ->
                    cb.like(cb.lower(root.get("title")), "%" + searchQuery.toLowerCase() + "%"));
        }

        return bookRepository.findAll(spec, pageable)
                .map(this::convertToResponseDTO);
    }

    public BookResponseDTO getBookById(Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found with id: " + id));
        return convertToResponseDTO(book);
    }

    @Transactional
    public BookResponseDTO updateBook(Long id, BookDTO bookDTO) {
        Book existingBook = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found with id: " + id));

        modelMapper.map(bookDTO, existingBook);

        // Handle file updates
        if (bookDTO.getBookFile() != null && !bookDTO.getBookFile().isEmpty()) {
            fileStorageService.deleteFile(existingBook.getFilePath());
            String filePath = fileStorageService.storeFile(bookDTO.getBookFile(), "books");
            existingBook.setFilePath(filePath);
            existingBook.setFileType(getFileType(bookDTO.getBookFile().getOriginalFilename()));
        }

        if (bookDTO.getCoverImage() != null && !bookDTO.getCoverImage().isEmpty()) {
            fileStorageService.deleteFile(existingBook.getCoverPath());
            String coverPath = fileStorageService.storeFile(bookDTO.getCoverImage(), "covers");
            existingBook.setCoverPath(coverPath);
        }

        Book updatedBook = bookRepository.save(existingBook);
        return convertToResponseDTO(updatedBook);
    }

    @Transactional
    public void deleteBook(Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found with id: " + id));

        if (book.getFilePath() != null) {
            fileStorageService.deleteFile(book.getFilePath());
        }

        if (book.getCoverPath() != null) {
            fileStorageService.deleteFile(book.getCoverPath());
        }

        bookRepository.delete(book);
    }

    public byte[] downloadBookFile(Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found with id: " + id));

        return fileStorageService.loadFileAsBytes(book.getFilePath());
    }

    public byte[] downloadBookCover(Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found with id: " + id));

        return fileStorageService.loadFileAsBytes(book.getCoverPath());
    }

    private BookResponseDTO convertToResponseDTO(Book book) {
        BookResponseDTO responseDTO = modelMapper.map(book, BookResponseDTO.class);
        responseDTO.setFileUrl("/api/books/" + book.getId() + "/download");
        // 修改封面URL为静态资源路径
        if (book.getCoverPath() != null) {
            // 只存储相对路径，返回时动态添加基础URL
            String coverFilename = book.getCoverPath().substring(book.getCoverPath().lastIndexOf("/") + 1);
            responseDTO.setCoverUrl(appConfig.getBaseUrl() + "/covers/" + coverFilename);
        }
        return responseDTO;
    }

    private String getFileType(String filename) {
        if (filename == null) return null;
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex > 0) {
            return filename.substring(dotIndex + 1).toUpperCase();
        }
        return null;
    }
}