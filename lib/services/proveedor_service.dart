import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen/models/proveedor.dart';

class ProveedorService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado_pro> proveedor = [];
  Listado_pro? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProveedorService() {
    loadProducts();
  }
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = Proveedor.fromJson(response.body);
    print(response.body);
    proveedor = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

Future editOrCreateProduct(Listado_pro proveedor , BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (proveedor.ProveedorId == 0) {
      await this.createProduct(proveedor);
    } else {
      await this.updateProduct(proveedor);
    }

    isEditCreate = false;
    notifyListeners();
    loadProducts();
    Navigator.pop(context);
  }

  Future<String> updateProduct(Listado_pro product) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson2(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = proveedor
    .indexWhere((element) => element.ProveedorId == product.ProveedorId);
    proveedor[index] = product;

    return '';
  }

  Future createProduct(Listado_pro proveedor) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedor.add(proveedor);
    return '';
  }

  Future deleteProduct(Listado_pro proveedor, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson2(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print("---------------");
    print(proveedor);
    print("---------------");
    this.proveedor.clear(); //borra todo el listado
    loadProducts();
    Navigator.pop(context);
    return '';
  }

}
