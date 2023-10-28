import 'package:examen/providers/proveedor_form_provider.dart';
import 'package:examen/services/proveedor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProveedorFormProvider(proveedorService.SelectProduct!),
        child: _ProductScreenBody(
          proveedorService: proveedorService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.proveedorService,
  }) : super(key: key);

  final  ProveedorService proveedorService;
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedor'),
        elevation: 1,
        backgroundColor: Colors. green,    
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.deleteProduct(proveedorForm.proveedor, context);
              print("asdasdsadsadsadsa");
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.editOrCreateProduct(proveedorForm.proveedor, context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProveedorFormProvider>(context);
    final product = productForm.proveedor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.ProveedorName,
                onChanged: (value) => product.ProveedorName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del proveedor',
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                initialValue: product.ProveedorLastName,
                onChanged: (value) => product.ProveedorLastName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el apellido es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Apellido del proveedor',
                  labelText: 'Apellido',
                ),
              ),
              TextFormField(
                initialValue: product.ProveedorCorreo,
                onChanged: (value) => product.ProveedorCorreo = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el correo es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Correo del proveedor',
                  labelText: 'Correo',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
                activeColor: Colors. green,
                title: const Text('Activo'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
