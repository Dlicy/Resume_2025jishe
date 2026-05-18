package com.example.computerdesign.Controller;

import com.example.computerdesign.DTO.BookDTO;
import com.example.computerdesign.DTO.BookResponseDTO;
import com.example.computerdesign.Service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<BookResponseDTO> addBook(@ModelAttribute BookDTO bookDTO) {
        System.out.println("添加书籍");
        BookResponseDTO responseDTO = bookService.addBook(bookDTO);
        return ResponseEntity.ok(responseDTO);
    }

    @GetMapping
    public ResponseEntity<Page<BookResponseDTO>> getAllBooks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search) {

        Pageable pageable = PageRequest.of(page, size);
        Page<BookResponseDTO> books = bookService.getAllBooks(pageable, search);
        return ResponseEntity.ok(books);
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookResponseDTO> getBookById(@PathVariable Long id) {
        System.out.println("输出");
        BookResponseDTO book = bookService.getBookById(id);
        return ResponseEntity.ok(book);
    }

    @PutMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<BookResponseDTO> updateBook(
            @PathVariable Long id,
            @ModelAttribute BookDTO bookDTO) {

        BookResponseDTO updatedBook = bookService.updateBook(id, bookDTO);
        return ResponseEntity.ok(updatedBook);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        bookService.deleteBook(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<byte[]> downloadBook(@PathVariable Long id) {
        byte[] fileContent = bookService.downloadBookFile(id);

        BookResponseDTO book = bookService.getBookById(id);
        String contentType = "application/octet-stream";
        if (book.getFileType() != null) {
            if (book.getFileType().equalsIgnoreCase("PDF")) {
                contentType = "application/pdf";
            } else if (book.getFileType().equalsIgnoreCase("DOCX")) {
                contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            }
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + book.getTitle() + "." + book.getFileType().toLowerCase() + "\"")
                .body(fileContent);
    }

    @GetMapping("/{id}/cover")
    public ResponseEntity<byte[]> getBookCover(@PathVariable Long id) {
        byte[] imageBytes = bookService.downloadBookCover(id);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(imageBytes);
    }


}