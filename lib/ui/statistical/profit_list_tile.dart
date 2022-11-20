import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../products/edit_product_screen.dart';
import '../products/products_manager.dart';

class ProFitListTile extends StatelessWidget {
  final Product product;
  const ProFitListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###');
    final total = DateTime.now();
    var day = product.date;
    return ListTile(
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
            width: 100,
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
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${formatter.format((((product.price * product.laisuat)/100)/product.kyhan)*total.difference(day).inDays) } VND'),
          Text('${total.difference(day).inDays} Ngày')
        ],
      ),
    );
  }
}
