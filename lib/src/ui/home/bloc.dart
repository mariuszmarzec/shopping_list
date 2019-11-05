import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

class HomePageBloc {

  final ShoppingListRepository _repository;
  final _initialState = HomePageState(products: []);
  final BehaviorSubject<HomePageState> _state = new BehaviorSubject<
      HomePageState>();

  HomePageBloc(this._repository) {
    _state.add(_initialState);
  }

  Observable<HomePageState> get state => _state.stream;

  void Function(Notification<List<Product>> notification) get onEach => null;

  load() async {
    _state.add(HomePageState(loading: true));
    Future.delayed(const Duration(seconds: 2), () {
      _repository
          .load()
          .map((products) => products.map((it) => it.name))
          .doOnData(((products) {
        _state.add(HomePageState(products: products));
      }))
      .doOnError((error) => _state.add(HomePageState(error: "Error loading")));
    });
  }

  dispose() async {
    _repository.close();
    _state.close();
  }
}

class HomePageState {
  final bool loading;
  final List<String> products;
  final String error;

  HomePageState({
    this.loading = false,
    this.products,
    this.error});
}