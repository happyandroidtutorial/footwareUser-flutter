import 'package:json_annotation/json_annotation.dart';
part 'product_category.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class ProductCategory {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  

  ProductCategory({
    this.id,
    this.name,
  
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}

class _$ProductCategory {
}
