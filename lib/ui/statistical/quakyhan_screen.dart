import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/products_manager.dart';
import 'quakyhan_list_tile.dart';

class QuaKyHanScreen extends StatelessWidget {
  static const routeName = '/kyhan';
  const QuaKyHanScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final total = context.read<ProductsManager>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách quá kỳ hạn'),
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
                          child: buildQuaKyHanListView(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Widget buildQuaKyHanListView() {
    return Consumer<ProductsManager>(builder: (ctx, productsManager, child) {
      return ListView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            QuaKyHanListTile(
              productsManager.items[i],
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
