import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

import 'MemoryDataSourceTest.dart';

class MockDataSource extends Mock implements DataSource {}

void main() {
  ShoppingListRepository repository;
  DataSource dataSource;
  setUp(() {
    dataSource = MockDataSource();
    when(dataSource.getAll()).thenAnswer((realInvocation) => Observable.just(ProductList([stubProduct(id: "1")])));
    repository = ShoppingListRepositoryImpl(dataSource);
  });

  test('adding to product', () async {
    await expectLater(
        repository.load(),
        emitsInOrder(<Resource<ProductList>>[
          Resource<ProductList>(loading: true),
          Resource<ProductList>(data : ProductList([stubProduct(id: "1")]))
        ]));
    verify(dataSource.getAll());
  });

  test('add', () async {
    when(dataSource.add([stubProduct(id : "2")])).thenAnswer((realInvocation) => Observable.just(ProductList([
      stubProduct(id: "1"),
      stubProduct(id: "2")
    ])));
    var observable = repository.load();
    repository.add(stubProduct(id : "2"));

    await expectLater(
        observable,
        emitsInOrder(<Resource<ProductList>>[
          Resource<ProductList>(loading: true),
          Resource<ProductList>(data : ProductList([stubProduct(id: "1")])),
          Resource<ProductList>(data : ProductList([stubProduct(id: "1"), stubProduct(id: "2")]))
        ]));
    verify(dataSource.getAll());
    verify(dataSource.add([stubProduct(id : "2")]));
  });

  test('remove', () async {
    when(dataSource.remove(["1"])).thenAnswer((realInvocation) => Observable.just(ProductList([])));
    var observable = repository.load();
    repository.remove(stubProduct(id : "1"));

    await expectLater(
        observable,
        emitsInOrder(<Resource<ProductList>>[
          Resource<ProductList>(loading: true),
          Resource<ProductList>(data : ProductList([stubProduct(id: "1")])),
          Resource<ProductList>(data : ProductList([]))
        ]));
    verify(dataSource.getAll());
    verify(dataSource.remove(["1"]));
  });
}