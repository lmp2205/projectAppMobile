import 'package:flutter/material.dart';
import 'package:myshop/ui/statistical/profit_list_tile.dart';
import 'package:provider/provider.dart';
import '../products/products_manager.dart';
import 'package:intl/intl.dart';


class ProFitScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const ProFitScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final total = context.read<ProductsManager>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Doanh thu'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Tổng giá trị: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Chip(
                      label:  buildTotal(total, context),
                      // label: Text('123'),
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                  ]),
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
                          child: buildProFitListView(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Widget buildProFitListView() {


    return Consumer<ProductsManager>(builder: (ctx, productsManager, child) {
      return ListView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            ProFitListTile(
              productsManager.items[i],
            ),
            const Divider(),
          ],
        ),
      );
    });
  }

  Widget buildTotal(ProductsManager total, BuildContext context) {
    var formatter = NumberFormat('###,###,###');

    return Text(
      '\$${formatter.format(total.totalAmount) }',
    );
  }
}
