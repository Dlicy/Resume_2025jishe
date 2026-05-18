package com.example.computerdesign.Controller.Unity;
import com.example.computerdesign.DAO.Unity.WherePoints;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.Unity.WherePointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/unity/points")
public class WherePointsController {

    @Autowired
    private WherePointsService wherePointService;


    @GetMapping
    public PointsWrapper getAllPoints() {
        System.out.println("正在访问");
        List<WherePoints> points = wherePointService.getAllPoints();

        List<PointResponse> response = points.stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());

        return new PointsWrapper(response);
    }

    @GetMapping("/with-id")
    public PointsWrapperWithId getAllPointsWithId() {
        System.out.println("正在访问带ID的穴位列表");
        List<WherePoints> points = wherePointService.getAllPoints();

        List<PointResponseWithId> response = points.stream()
                .map(this::convertToResponseWithId)
                .collect(Collectors.toList());

        return new PointsWrapperWithId(response);
    }


    @PostMapping
    public Response addAcupoint(@RequestBody WherePoints newPoint) {
        try {
            // 数据验证
            if (newPoint.getModelName() == null || newPoint.getModelName().trim().isEmpty()) {
                return Response.newFail("穴位不能为空！");
            }

            // 设置默认值（可选）
            if (newPoint.getScaleX() == null) newPoint.setScaleX(BigDecimal.ONE);
            if (newPoint.getScaleY() == null) newPoint.setScaleY(BigDecimal.ONE);
            if (newPoint.getScaleZ() == null) newPoint.setScaleZ(BigDecimal.ONE);

            // 保存到数据库
            WherePoints savedPoint = wherePointService.savePoint(newPoint);

            // 返回成功响应
            return Response.newSuccess("穴位添加成功！");

        } catch (Exception e) {
            return Response.newFail(e.getMessage());
        }
    }


    // 新增的响应数据结构（包含ID）
    private static class PointsWrapperWithId {
        private List<PointResponseWithId> models;

        public PointsWrapperWithId(List<PointResponseWithId> models) {
            this.models = models;
        }

        // getter和setter
        public List<PointResponseWithId> getModels() {
            return models;
        }

        public void setModels(List<PointResponseWithId> models) {
            this.models = models;
        }
    }

    // 新增的响应数据结构（包含ID）
    private static class PointResponseWithId {
        private Integer id;  // 新增ID字段
        private String modelName;
        private String path;
        private Position position;
        private Position localPosition;
        private Rotation rotation;
        private Rotation localRotation;
        private Scale scale;

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getModelName() {
            return modelName;
        }

        public void setModelName(String modelName) {
            this.modelName = modelName;
        }

        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }

        public Position getPosition() {
            return position;
        }

        public void setPosition(Position position) {
            this.position = position;
        }

        public Position getLocalPosition() {
            return localPosition;
        }

        public void setLocalPosition(Position localPosition) {
            this.localPosition = localPosition;
        }

        public Rotation getRotation() {
            return rotation;
        }

        public void setRotation(Rotation rotation) {
            this.rotation = rotation;
        }

        public Rotation getLocalRotation() {
            return localRotation;
        }

        public void setLocalRotation(Rotation localRotation) {
            this.localRotation = localRotation;
        }

        public Scale getScale() {
            return scale;
        }

        public void setScale(Scale scale) {
            this.scale = scale;
        }
    }

    // 新增的转换方法（包含ID）
    private PointResponseWithId convertToResponseWithId(WherePoints point) {
        PointResponseWithId response = new PointResponseWithId();
        response.setId(point.getId());  // 设置ID
        response.setModelName(point.getModelName());
        response.setPath(point.getPath());

        // 位置信息
        Position position = new Position();
        position.setX(point.getPositionX());
        position.setY(point.getPositionY());
        position.setZ(point.getPositionZ());
        response.setPosition(position);

// 设置局部位置信息
        Position localPosition = new Position();
        localPosition.setX(point.getLocalPositionX());
        localPosition.setY(point.getLocalPositionY());
        localPosition.setZ(point.getLocalPositionZ());
        response.setLocalPosition(localPosition);

        // 设置旋转信息
        Rotation rotation = new Rotation();
        rotation.setX(point.getRotationX());
        rotation.setY(point.getRotationY());
        rotation.setZ(point.getRotationZ());
        rotation.setW(point.getRotationW());
        response.setRotation(rotation);

        // 设置局部旋转信息
        Rotation localRotation = new Rotation();
        localRotation.setX(point.getLocalRotationX());
        localRotation.setY(point.getLocalRotationY());
        localRotation.setZ(point.getLocalRotationZ());
        localRotation.setW(point.getLocalRotationW());
        response.setLocalRotation(localRotation);

        // 设置缩放信息
        Scale scale = new Scale();
        scale.setX(point.getScaleX());
        scale.setY(point.getScaleY());
        scale.setZ(point.getScaleZ());
        response.setScale(scale);

        return response;
    }

    // 更新穴位
    @PutMapping("/{id}")
    public Response updateAcupoint(
            @PathVariable Integer id,
            @RequestBody WherePoints updatedPoint) {
        try {
            if (!wherePointService.existsById(id)) {
                return Response.newFail("穴位不存在");
            }

            updatedPoint.setId(id);
            WherePoints savedPoint = wherePointService.savePoint(updatedPoint);
            return Response.newSuccess("穴位更新成功");
        } catch (Exception e) {
            return Response.newFail(e.getMessage());
        }
    }

    // 删除穴位
    @DeleteMapping("/{id}")
    public Response deleteAcupoint(@PathVariable Integer id) {
        System.out.println("正在删除穴位");
        try {
            if (!wherePointService.existsById(id)) {
                return Response.newFail("穴位不存在");
            }

            wherePointService.deletePoint(id);
            return Response.newSuccess("穴位删除成功");
        } catch (Exception e) {
            return Response.newFail(e.getMessage());
        }
    }


    private PointResponse convertToResponse(WherePoints point) {
        PointResponse response = new PointResponse();
        response.setModelName(point.getModelName());
        response.setPath(point.getPath());

        // 设置位置信息
        Position position = new Position();
        position.setX(point.getPositionX());
        position.setY(point.getPositionY());
        position.setZ(point.getPositionZ());
        response.setPosition(position);

        // 设置局部位置信息
        Position localPosition = new Position();
        localPosition.setX(point.getLocalPositionX());
        localPosition.setY(point.getLocalPositionY());
        localPosition.setZ(point.getLocalPositionZ());
        response.setLocalPosition(localPosition);

        // 设置旋转信息
        Rotation rotation = new Rotation();
        rotation.setX(point.getRotationX());
        rotation.setY(point.getRotationY());
        rotation.setZ(point.getRotationZ());
        rotation.setW(point.getRotationW());
        response.setRotation(rotation);

        // 设置局部旋转信息
        Rotation localRotation = new Rotation();
        localRotation.setX(point.getLocalRotationX());
        localRotation.setY(point.getLocalRotationY());
        localRotation.setZ(point.getLocalRotationZ());
        localRotation.setW(point.getLocalRotationW());
        response.setLocalRotation(localRotation);

        // 设置缩放信息
        Scale scale = new Scale();
        scale.setX(point.getScaleX());
        scale.setY(point.getScaleY());
        scale.setZ(point.getScaleZ());
        response.setScale(scale);

        return response;
    }

    // 内部类定义响应数据结构
    private static class PointsWrapper {
        private List<PointResponse> models;

        public PointsWrapper(List<PointResponse> models) {
            this.models = models;
        }

        public List<PointResponse> getModels() {
            return models;
        }

        public void setModels(List<PointResponse> models) {
            this.models = models;
        }
    }

    private static class PointResponse {
        private String modelName;
        private String path;
        private Position position;
        private Position localPosition;
        private Rotation rotation;
        private Rotation localRotation;
        private Scale scale;

        // getters and setters
        public String getModelName() {
            return modelName;
        }

        public void setModelName(String modelName) {
            this.modelName = modelName;
        }

        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }

        public Position getPosition() {
            return position;
        }

        public void setPosition(Position position) {
            this.position = position;
        }

        public Position getLocalPosition() {
            return localPosition;
        }

        public void setLocalPosition(Position localPosition) {
            this.localPosition = localPosition;
        }

        public Rotation getRotation() {
            return rotation;
        }

        public void setRotation(Rotation rotation) {
            this.rotation = rotation;
        }

        public Rotation getLocalRotation() {
            return localRotation;
        }

        public void setLocalRotation(Rotation localRotation) {
            this.localRotation = localRotation;
        }

        public Scale getScale() {
            return scale;
        }

        public void setScale(Scale scale) {
            this.scale = scale;
        }
    }

    private static class Position {
        private BigDecimal x;
        private BigDecimal y;
        private BigDecimal z;

        public BigDecimal getX() {
            return x;
        }

        public void setX(BigDecimal x) {
            this.x = x;
        }

        public BigDecimal getY() {
            return y;
        }

        public void setY(BigDecimal y) {
            this.y = y;
        }

        public BigDecimal getZ() {
            return z;
        }

        public void setZ(BigDecimal z) {
            this.z = z;
        }
    }

    private static class Rotation {
        private BigDecimal x;
        private BigDecimal y;
        private BigDecimal z;
        private BigDecimal w;

        public BigDecimal getX() {
            return x;
        }

        public void setX(BigDecimal x) {
            this.x = x;
        }

        public BigDecimal getY() {
            return y;
        }

        public void setY(BigDecimal y) {
            this.y = y;
        }

        public BigDecimal getZ() {
            return z;
        }

        public void setZ(BigDecimal z) {
            this.z = z;
        }

        public BigDecimal getW() {
            return w;
        }

        public void setW(BigDecimal w) {
            this.w = w;
        }
    }

    private static class Scale {
        private BigDecimal x;
        private BigDecimal y;
        private BigDecimal z;

        public BigDecimal getX() {
            return x;
        }

        public void setX(BigDecimal x) {
            this.x = x;
        }

        public BigDecimal getY() {
            return y;
        }

        public void setY(BigDecimal y) {
            this.y = y;
        }

        public BigDecimal getZ() {
            return z;
        }

        public void setZ(BigDecimal z) {
            this.z = z;
        }
    }
}