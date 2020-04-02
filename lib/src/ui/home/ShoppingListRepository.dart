import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';

abstract class ShoppingListRepository {

  Observable<Resource<ProductList>> load();

  void close();
}

class ShoppingListRepositoryImpl extends ShoppingListRepository {

  final DataSource dataSource;

  ShoppingListRepositoryImpl(this.dataSource);

  final BehaviorSubject<Resource<ProductList>> _state = new BehaviorSubject<
      Resource<ProductList>>();

  @override
  Observable<Resource<ProductList>> load() {
    var list = [new Product("1", "Carrot"), new Product("2", "water")];
    _state.add(Resource(loading: true));
    Future.delayed(const Duration(seconds: 2), () {
      _state.add(Resource(data: ProductList(list)));
    });
    return _state;
  }

  @override
  void close() {
    _state.close();
  }

}