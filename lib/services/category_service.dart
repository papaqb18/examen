import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen/models/categoria.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado_cat> category = [];
  Listado_cat? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadProducts();
  }
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = Category.fromJson(response.body);
    print(response.body);
    category = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

Future editOrCreateProduct(Listado_cat product, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (product.CategoryId == 0) {
      await this.createProduct(product);
    } else {
      await this.updateProduct(product);
    }

    isEditCreate = false;
    notifyListeners();
    loadProducts();
    Navigator.pop(context);
  }

  Future<String> updateProduct(Listado_cat product) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = category
        .indexWhere((element) => element.CategoryId == product.CategoryId);
    category[index] = product;

    return '';
  }

  Future createProduct(Listado_cat product) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.category.add(product);
    return '';
  }

  Future deleteProduct(Listado_cat product, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.category.clear(); //borra todo el listado
    loadProducts();
    Navigator.pop(context);
    return '';
  }

}
