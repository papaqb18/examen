import 'dart:convert';

class Category {
  Category({
    required this.listado,
  });

  List<Listado_cat> listado;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        listado:
            List<Listado_cat>.from(json["Listado Categorias"].map((x) => Listado_cat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Listado_cat {
  Listado_cat({
    required this.CategoryId,
    required this.CategoryName,
    required this.CategoryState,
  });

  int CategoryId;
  String CategoryName;
  String CategoryState;

  factory Listado_cat.fromJson(String str) => Listado_cat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado_cat.fromMap(Map<String, dynamic> json) => Listado_cat(
        CategoryId: json["category_id"],
        CategoryName: json["category_name"],
        CategoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": CategoryId,
        "category_name": CategoryName,
        "category_state": CategoryState,
      };

  Listado_cat copy() => Listado_cat(
      CategoryId: CategoryId,
      CategoryName: CategoryName,
      CategoryState: CategoryState);
}
