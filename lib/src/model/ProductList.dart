import 'package:equatable/equatable.dart';

import 'Product.dart';

class ProductList extends Equatable {

  final List<Product> products;

  ProductList(this.products);

  @override
  List<Object> get props => [products];

  @override
  String toString() {
    return products?.fold("", (prev, el) {
      return prev + ", " + el.name;
    });
  }
}