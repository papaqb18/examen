import 'package:examen/services/category_service.dart';
import 'package:examen/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:examen/models/categoria.dart';
import 'package:provider/provider.dart';
import 'package:examen/screen/screen.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Listado de categoria'),
      ),
      body: ListView.builder(
        itemCount: categoryService.category.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            categoryService.SelectProduct =
                categoryService.category[index].copy();
            Navigator.pushNamed(context, 'edit_category');
          },
          child: CategoryCard(category: categoryService.category[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.SelectProduct = Listado_cat(
               CategoryId: 0,
               CategoryName: '',
               CategoryState: 'Activo');
          Navigator.pushNamed(context, 'edit_category');
        },
      ),


    );
  }
}
