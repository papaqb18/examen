import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.listado,
  });

  List<Listado_pro> listado;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        listado:
            List<Listado_pro>.from(json["Proveedores Listado"].map((x) => Listado_pro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Listado_pro {
  Listado_pro({
    required this.ProveedorId,
    required this.ProveedorName,
    required this.ProveedorLastName,
    required this.ProveedorCorreo,
    required this.ProveedorState,
  });

  int ProveedorId;
  String ProveedorName;
  String ProveedorLastName;
  String ProveedorCorreo;
    String ProveedorState;

  factory Listado_pro.fromJson(String str) => Listado_pro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  String toJson2() => json.encode(toMap2());

  factory Listado_pro.fromMap(Map<String, dynamic> json) => Listado_pro(
        ProveedorId: json["providerid"],
        ProveedorName: json["provider_name"],
        ProveedorLastName: json["provider_last_name"],
        ProveedorCorreo: json["provider_mail"],
        ProveedorState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": ProveedorId,
        "provider_name": ProveedorName,
        "provider_last_name": ProveedorLastName,
        "provider_mail": ProveedorCorreo,
        "provider_state": ProveedorState,
      };
       Map<String, dynamic> toMap2() => {
        "provider_id": ProveedorId,
        "provider_name": ProveedorName,
        "provider_last_name": ProveedorLastName,
        "provider_mail": ProveedorCorreo,
        "provider_state": ProveedorState,
      };

  Listado_pro copy() => Listado_pro(
      ProveedorId: ProveedorId,
      ProveedorName: ProveedorName,
      ProveedorLastName: ProveedorLastName,
      ProveedorCorreo: ProveedorCorreo,
      ProveedorState: ProveedorState,);
      
}
