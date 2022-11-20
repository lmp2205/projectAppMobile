import 'package:flutter/material.dart';
import 'user_products_list_tile.dart';
import 'package:provider/provider.dart';
import '../products/products_manager.dart';



class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        backgroundColor: Colors.amber,
        centerTitle: true,
        // actions: <Widget>[
        //   buildAddButton(context),
        // ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => print('refresh products'),
            child: buildUserProductListView(),
          );
        }
      )
    );
  }
  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      }
    );
  }
  
}