import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../products/products_manager.dart';
import 'Utils.dart';
import 'category_list_tile.dart';

class categoryScreen extends StatelessWidget {
  static const routeName = '/danhmuc';

  const categoryScreen({super.key});
  

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Danh mục'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: _refreshProducts(context),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async => print('refresh products'),
                        child: Container(
                          child: buildKyHanListView(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Widget buildKyHanListView() {
    return Consumer<ProductsManager>(builder: (ctx, productsManager, child) {
      String a = 'vang';
      return ListView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            if ( a == a ) ...[
              categoryListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ]
          ],
        ),
      );
    });
  }

  Widget buildTotal(ProductsManager total, BuildContext context) {
    return Text(
      '\$${total.totalAmount.toStringAsFixed(2)}',
    );
  }
}
