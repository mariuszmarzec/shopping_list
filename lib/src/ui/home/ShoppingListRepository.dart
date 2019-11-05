import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';

abstract class ShoppingListRepository {

  Observable<List<Product>> load();

  void close();
}

class ShoppingListRepositoryImpl extends ShoppingListRepository {

  final BehaviorSubject<List<Product>> _state = new BehaviorSubject<List<Product>>();

  @override
  Observable<List<Product>> load() {
    _state.add([new Product("1", "Carrot"), new Product("2", "water")]);
    return _state.stream;
  }

  @override
  void close() {
    _state.close();
  }

}