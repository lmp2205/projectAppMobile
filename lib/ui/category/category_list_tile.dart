import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../products/edit_product_screen.dart';
import '../products/products_manager.dart';


class categoryListTile extends StatelessWidget {
  final Product product;
  const categoryListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final total = DateTime.now();
    var day = product.date;
    return Column(
      children: [
        if (total.difference(day).inDays > product.kyhan) ...[
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 85,
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
            ),
            trailing: SizedBox(
              width: 110,
              child: Row(
                children: <Widget>[
                  Text('${(total.difference(day).inDays)} Ngày'),
                ],
              ),
            ),
            onTap: (){
             buildKyHanListView();
            },
          )
        ]
      ],
    );
  }

 Widget buildKyHanListView() {
    return Consumer<ProductsManager>(builder: (ctx, productsManager, child) {
      return ListView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => Column(
          children: [
            categoryListTile(
              productsManager.items[i],
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
