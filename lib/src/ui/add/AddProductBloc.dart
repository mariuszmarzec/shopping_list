import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/constants/Constants.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';

class AddProductBloc {
  final ShoppingListRepository _repository;
  final Uuid _uuid;

  final CompositeSubscription _compositeSubscription = CompositeSubscription();

  final BehaviorSubject<AddProductState> _state =
      new BehaviorSubject<AddProductState>();

  Observable<AddProductState> get state => _state.stream;

  AddProductState get initialState => AddProductState(
      AddProductStep.EDIT,
      Product(_uuid.v1(), Constants.EMPTY, Constants.EMPTY, ProductUnit.NONE,
          ProductType.OTHER));


  AddProductBloc(this._repository, this._uuid) {
    _state.add(initialState);
  }

  void dispose() {
    _repository.close();
    _compositeSubscription.dispose();
  }

  void onAddButtonClick(void Function() onSuccess) {
    final StreamSubscription<AddProductState> ss =
        _state.first.asStream().listen((state) {
      final StreamSubscription<Resource<ProductList>> ss =
          _repository.add(state.product).listen((res) {
        if (res.error != null) {
          // TODO ERROR
        } else if (res.data != null) {
          _state.add(AddProductState(AddProductStep.SUCCESS, state.product));
          onSuccess();
        } else {
          _state.add(AddProductState(
              AddProductStep.ADDING_IN_PROGRESS, state.product));
        }
      });
      _compositeSubscription.add(ss);
    });
    _compositeSubscription.add(ss);
  }

  setName(String name) {
    final StreamSubscription<AddProductState> ss =
        _state.first.asStream().listen((state) {
      final newProduct = Product(state.product.id, name, state.product.count,
          state.product.unit, state.product.type, state.product.checked);
      _state.add(AddProductState(AddProductStep.EDIT, newProduct));
    });
    _compositeSubscription.add(ss);
  }

  setCount(String count) {
    final StreamSubscription<AddProductState> ss =
        _state.first.asStream().listen((state) {
      final newProduct = Product(state.product.id, state.product.name, count,
          state.product.unit, state.product.type, state.product.checked);
      _state.add(AddProductState(AddProductStep.EDIT, newProduct));
    });
    _compositeSubscription.add(ss);
  }

  setType(ProductType newType) {
    final StreamSubscription<AddProductState> ss =
        _state.first.asStream().listen((state) {
      final newProduct = Product(
          state.product.id,
          state.product.name,
          state.product.count,
          state.product.unit,
          newType,
          state.product.checked);
      _state.add(AddProductState(AddProductStep.EDIT, newProduct));
    });
    _compositeSubscription.add(ss);
  }

  setUnit(ProductUnit newUnit) {
    final StreamSubscription<AddProductState> ss =
        _state.first.asStream().listen((state) {
      final newProduct = Product(
          state.product.id,
          state.product.name,
          state.product.count,
          newUnit,
          state.product.type,
          state.product.checked);
      _state.add(AddProductState(AddProductStep.EDIT, newProduct));
    });
    _compositeSubscription.add(ss);
  }
}

enum AddProductStep { EDIT, ADDING_IN_PROGRESS, SUCCESS }

class AddProductState {
  final AddProductStep step;
  final Product product;

  AddProductState(this.step, this.product);
}
