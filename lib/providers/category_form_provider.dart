import 'package:flutter/material.dart';
import 'package:examen/models/categoria.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Listado_cat categoria;
  CategoryFormProvider(this.categoria);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
