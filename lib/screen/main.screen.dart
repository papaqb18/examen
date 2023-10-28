import 'package:examen/screen/homescreen.dart';
import 'package:examen/screen/list_category_screen.dart';
import 'package:examen/screen/list_product_screen.dart';
import 'package:examen/screen/list_proveedores_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    ListProveedoresScreen(),
    ListCategoryScreen(),
    ListProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 15, 114, 17),
        
        items:[
      
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Inicio' ,
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Proveedores' ,
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart),
          label: 'Categorias' ,
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.equal_square),
          label: 'Productos' ,
          ),
          
      ]
      ),
      body: _pages[_pageIndex],
    );
    
  }
}