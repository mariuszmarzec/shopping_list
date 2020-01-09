import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

class HomePageBloc {

  final ShoppingListRepository _repository;
  final _initialState = Resource(data: ProductList([]));
  final BehaviorSubject<Resource<ProductList>> _state = new BehaviorSubject<
      Resource<ProductList>>();

  HomePageBloc(this._repository) {
    _state.add(_initialState);
  }

  Observable<Resource<ProductList>> get state => _state.stream;

  load() async {
    _repository.load().listen((data) {
      _state.add(data);
    });
  }

  dispose() async {
    _repository.close();
    _state.close();
  }
}