import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';

abstract class ShoppingListRepository {

  Observable<Resource<ProductList>> load();

  Observable<Resource<ProductList>> add(Product product);

  Observable<Resource<ProductList>> remove(Product product);

  void markAsChecked(Product product);

  void markAsUnchecked(Product product);

  void close();
}

class ShoppingListRepositoryImpl extends ShoppingListRepository {

  final DataSource dataSource;
  CompositeSubscription compositeSubscription = CompositeSubscription();

  ShoppingListRepositoryImpl(this.dataSource);

  final BehaviorSubject<Resource<ProductList>> _state = new BehaviorSubject<
      Resource<ProductList>>();

  @override
  Observable<Resource<ProductList>> load() {
    StreamSubscription<Resource<ProductList>> ss = dataSource.getAll()
        .map((event) => Resource(data: event))
        .startWith(Resource(loading: true))
        .listen((event) { _state.add(event); });
    compositeSubscription.add(ss);
    return _state;
  }

  @override
  void close() {
    compositeSubscription.clear();
    _state.close();
  }

  @override
  Observable<Resource<ProductList>> add(Product product) {
    return dataSource.add([product])
        .map((event) => Resource(data: event))
        .doOnEach((event) { _state.add(event.value); });
  }

  @override
  Observable<Resource<ProductList>> remove(Product product) {
    return dataSource.remove([product.id])
        .map((event) => Resource(data: event))
        .doOnEach((event) { _state.add(event.value); });
  }

  @override
  void markAsChecked(Product product) {
    StreamSubscription<Resource<ProductList>> ss =
    dataSource.markAsChecked(product.id)
        .map((event) => Resource(data: event))
        .listen((event) { _state.add(event); });
    compositeSubscription.add(ss);
  }

  @override
  void markAsUnchecked(Product product) {
    StreamSubscription<Resource<ProductList>> ss =
    dataSource.markAsUnchecked(product.id)
        .map((event) => Resource(data: event))
        .listen((event) { _state.add(event); });
    compositeSubscription.add(ss);
  }
}