import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';

abstract class DataSource {
  Observable<ProductList> getAll();

  Observable<ProductList> add(List<Product> products);

  Observable<ProductList> markAsChecked(String productId);

  Observable<ProductList> markAsUnchecked(String productId);

  Observable<ProductList> remove(List<String> ids);
}

class MemoryDataSourceImpl extends DataSource {
//  ProductList productList = ProductList([]);
  ProductList productList = ProductList([
    Product("1", "Pomidory", "1", ProductUnit.KG,
        ProductType.FRUITS_AND_VEGETABLES, true),
    Product(
        "2", "Marchew", "1", ProductUnit.KG, ProductType.FRUITS_AND_VEGETABLES),
    Product("3", "Bułki", "1", ProductUnit.ITEM, ProductType.BREAD),
  ]);

  final BehaviorSubject<ProductList> _state = new BehaviorSubject<ProductList>();

  MemoryDataSourceImpl() {
    _state.add(productList);
  }

  @override
  Observable<ProductList> getAll() {
    return _state;
  }

  @override
  Observable<ProductList> add(List<Product> products) {
    var newList = List<Product>.from(productList.products);
    newList.addAll(products);
    productList = ProductList(newList);
    _state.add(productList);
    return Observable.just(productList);
  }

  @override
  Observable<ProductList> remove(List<String> ids) {
    var newList = List<Product>.from(productList.products);
    newList.removeWhere((item) {
      return ids.contains(item.id);
    });
    productList = ProductList(newList);
    _state.add(productList);
    return Observable.just(productList);
  }

  @override
  Observable<ProductList> markAsChecked(String productId) {
    return changeMarkedState(productId, true);
  }

  Observable<ProductList> changeMarkedState(String productId, bool newState) {
    List<Product> products = productList.products.map((product) {
      if (product.id == productId) {
        return Product(product.id, product.name, product.count, product.unit,
            product.type, newState);
      } else {
        return product;
      }
    }).toList();
    productList = ProductList(products);
    _state.add(productList);
    return Observable.just(productList);
  }

  @override
  Observable<ProductList> markAsUnchecked(String productId) {
    return changeMarkedState(productId, false);
  }
}

DataSource dataSource = MemoryDataSourceImpl();
