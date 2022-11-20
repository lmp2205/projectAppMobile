import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../products/edit_product_screen.dart';
import '../products/products_manager.dart';

class QuaKyHanListTile extends StatelessWidget {
  final Product product;
  const QuaKyHanListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final total = DateTime.now();
    var day = product.date;
    return Column(
      children: [
        if (total.difference(day).inDays > product.kyhan*2) ...[
          ListTile(
            title: Row(
              
              children: [
          SizedBox(
            width: 50,
            child: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: 70,
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
            trailing:
            SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            Text('${(total.difference(day).inDays)} Ngày'),
            buildDeleteButton(context),

          ],
        ),
      ),
          )
        ] 
      ],
    );
        
  }
   Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        context.read<ProductsManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              )
            )
          );
      },
      color: Theme.of(context).errorColor,
    );
  }
}


