import 'package:flutter/material.dart';

import '../../models/product.dart';

import 'products_detail_screen.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: buildGridFooterBar(context),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id,
                  );
                },
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ))));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.amberAccent,
      title: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              product.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.3,
            ),
          ),
          SizedBox(
            width: 73,
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
