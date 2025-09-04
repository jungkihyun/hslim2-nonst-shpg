package com.hslim2.nonstshpg.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor   // ✅ 이거 추가
@Builder
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "상품명은 필수입니다")
    private String name;

    @Column(length = 1000)
    private String description;

    @NotNull(message = "가격은 필수입니다")
    @Positive(message = "가격은 0보다 커야 합니다")
    private Integer price;

    @Enumerated(EnumType.STRING)
    private Category category;

    private String origin; // 원산지

    private String imageUrl;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public enum Category {
        VEGETABLE("채소"),
        FRUIT("과일"),
        GRAIN("곡물"),
        PROCESSED("가공식품"),
        DAIRY("유제품"),
        MEAT("육류");

        private final String displayName;

        Category(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}
