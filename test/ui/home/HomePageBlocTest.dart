import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';
import 'package:shopping_list/src/ui/home/bloc.dart';

import 'MemoryDataSourceTest.dart';

class MockShoppingListRepository extends Mock implements ShoppingListRepository {}

void main() {
  HomePageBloc bloc;
  ShoppingListRepository repository;
  setUp(() {
    repository = MockShoppingListRepository();
    when(repository.load()).thenAnswer((_) {
      return Observable.just(Resource<ProductList>(data: new ProductList([new Product("id", "product")])));
    });

    bloc = HomePageBloc(repository);
  });

  tearDown(() {
    bloc.dispose();
  });
  
  test('initial state is correct', () {
    expect(bloc.state, emitsInOrder(<Resource<ProductList>>[Resource<ProductList>(data: ProductList([]))]));
  });

  test('update from repository is propagated to bloc state', () async {
    bloc.load();

    await expectLater(bloc.state, emitsInOrder(<Resource<ProductList>>[
      Resource<ProductList>(data: ProductList([])),
      Resource<ProductList>(data: ProductList([Product("id", "product")]))
    ]));

    verify(repository.load());
  });

  test('mark as checked', () async {
    bloc.check(stubProduct(id: "1"));

    verify(repository.markAsChecked(stubProduct(id: "1")));
  });

  test('mark as checked', () async {
    bloc.uncheck(stubProduct(id: "1"));

    verify(repository.markAsUnchecked(stubProduct(id: "1")));
  });
}