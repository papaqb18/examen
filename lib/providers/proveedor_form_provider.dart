import 'package:flutter/material.dart';
import 'package:examen/models/proveedor.dart';

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Listado_pro proveedor;
  ProveedorFormProvider(this.proveedor);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
