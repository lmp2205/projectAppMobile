import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../products/edit_product_screen.dart';
import '../products/products_manager.dart';
import '../products/edit_product_screen.dart';

class KyHanListTile extends StatelessWidget {
  final Product product;
  const KyHanListTile(
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
                  buildEditButton(context),
                ],
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.check_circle),
      onPressed: () async {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}
