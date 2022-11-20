import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../models/product.dart';
import '../../models/auth_token.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);


  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }
  

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }


  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }
  Product findById(String id) {
    return _items.firstWhere((pro) => pro.id == id);
  }
 

  double get totalAmount {
    var  total = 0.0;
    final formatter = NumberFormat('###,###,000');

    for (var product in _items) {
      total += (((product.price * product.laisuat)/100)/product.kyhan)*DateTime.now().difference(product.date).inDays;
    }
    return  total;
  }

}
