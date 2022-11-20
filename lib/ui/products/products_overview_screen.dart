import 'package:flutter/material.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import 'products_grid.dart';
import '../shared/app_drawer.dart';


enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  DateTime _dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang ký gửi'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      // drawer: const AppDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            
            Expanded(
              child: FutureBuilder(
                future: _fetchProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ValueListenableBuilder<bool>(
                        valueListenable: _showOnlyFavorites,
                        builder: (context, onlyFavorites, child) {
                          return ProductsGrid(onlyFavorites);
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  

 
}
