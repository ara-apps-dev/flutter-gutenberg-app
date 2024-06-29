import '../../../domain/entities/book/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required super.currentPage,
    required super.totalPages,
    required super.perPage,
    required super.totalCount,
  });

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) =>
      PaginationMetaDataModel(
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        perPage: json["per_page"],
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_pages": totalPages,
        "per_page": perPage,
        "total_count": totalCount,
      };
}
