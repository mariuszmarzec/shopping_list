import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomePageBloc {

  final initialState = HomePageState(products: []);
  final BehaviorSubject<HomePageState> _state = new BehaviorSubject<HomePageState>();

  HomePageBloc() {
    _state.add(initialState);
  }

  Observable<HomePageState> get state => _state.stream;

  load() async {
    _state.add(HomePageState(loading: true));
    Future.delayed(const Duration(seconds: 2), () {
      _state.add(HomePageState(products: ['first product', 'second product']));
    });
  }

  dispose() async {
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