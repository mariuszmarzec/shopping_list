import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';

abstract class DataSource {
  Observable<ProductList> getAll();

  Observable<ProductList> add(List<Product> products);

  Observable<ProductList> remove(List<String> ids);
}

class MemoryDataSourceImpl extends DataSource {
  ProductList productList = ProductList([]);

  // ignore: close_sinks

  @override
  Observable<ProductList> getAll() {
    return Observable.just(productList);
  }

  @override
  Observable<ProductList> add(List<Product> products) {
    var newList = List<Product>.from(productList.products);
    newList.addAll(products);
    productList = ProductList(newList);
    return Observable.just(productList);
  }

  @override
  Observable<ProductList> remove(List<String> ids) {
    var newList = List<Product>.from(productList.products);
    newList.removeWhere((item) {
      return ids.contains(item.id);
    });
    productList = ProductList(newList);
    return Observable.just(productList);
  }
}

DataSource dataSource = MemoryDataSourceImpl();
