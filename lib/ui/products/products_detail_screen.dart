import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,000');
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                )),
            Text(
              'Vật : ${product.title}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Họ và tên: ${product.name}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Số tiền: ${formatter.format(product.price)}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Ngày cầm: ${DateFormat('yyyy-MM-dd').format(product.date)}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Số điện thoại: 0${product.phone}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'CMND/CCCD: ${product.cmnd}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Kỳ hạn: ${product.kyhan}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Lãi suất: ${product.laisuat}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                'Mã hiệu/ Biển số: ${product.plate}',
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
