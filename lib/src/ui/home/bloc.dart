import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

class HomePageBloc {

  final ShoppingListRepository _repository;
  final _initialState = Resource(data: ProductList([]));
  CompositeSubscription _compositeSubscription = CompositeSubscription();
  final BehaviorSubject<Resource<ProductList>> _state = new BehaviorSubject<
      Resource<ProductList>>();

  HomePageBloc(this._repository) {
    _state.add(_initialState);
  }

  Observable<Resource<ProductList>> get state => _state;

  load() async {
    _compositeSubscription.add(_repository.load().listen((data) {
      if (data != null) {
        _state.add(data);
      }
    }));
  }

  dispose() async {
    _compositeSubscription.dispose();
    _repository.close();
    _state.close();
  }

  void onRemoveButtonClick(Product product) {
    _compositeSubscription.add(
        _repository.remove(product).listen((data) {
          _state.add(data);
        })
    );
  }

  void check(Product product) {
    _repository.markAsChecked(product);
  }

  void uncheck(Product product) {
    _repository.markAsUnchecked(product);
  }
}