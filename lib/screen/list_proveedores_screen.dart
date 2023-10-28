import 'package:examen/services/proveedor_service.dart';
import 'package:examen/widgets/proveedores_card.dart';
import 'package:flutter/material.dart';
import 'package:examen/models/proveedor.dart';
import 'package:provider/provider.dart';
import 'package:examen/screen/screen.dart';

class ListProveedoresScreen extends StatelessWidget {
  const ListProveedoresScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    if (proveedorService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Listado de proveedor'),
      ),
      body: ListView.builder(
        itemCount: proveedorService.proveedor.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            proveedorService.SelectProduct =
                proveedorService.proveedor[index].copy();
            Navigator.pushNamed(context, 'edit_proveedor');
            
          },
          child: ProveedoresCard(proveedor: proveedorService.proveedor[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          proveedorService.SelectProduct = Listado_pro(
               ProveedorId: 0,
               ProveedorName: '',
               ProveedorLastName: '',
               ProveedorCorreo: '',
               ProveedorState: 'Activo');
          Navigator.pushNamed(context, 'edit_proveedor');
        },
      ),


    );
  }
}
