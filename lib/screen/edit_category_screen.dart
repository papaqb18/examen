import 'package:flutter/material.dart';
import 'package:examen/providers/category_form_provider.dart';
import 'package:examen/services/category_service.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(categoryService.SelectProduct!),
        child: _ProductScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final  CategoryService categoryService;
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Categoria'),
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
              if (!categoryForm.isValidForm()) return;
              await categoryService.deleteProduct(categoryForm.categoria, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.editOrCreateProduct(categoryForm.categoria,context);
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
    final productForm = Provider.of<CategoryFormProvider>(context);
    final product = productForm.categoria;

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
                initialValue: product.CategoryName,
                onChanged: (value) => product.CategoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
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
