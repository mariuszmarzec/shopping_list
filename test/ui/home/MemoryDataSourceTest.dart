import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';

void main() {
  DataSource dataSource;
  setUp(() {
    dataSource = MemoryDataSourceImpl();
  });

  test('initial state is empty', () {
    expect(dataSource.getAll(), emitsInOrder(<ProductList>[ProductList([])]));
  });

  test('adding to product', () async {
    await expectLater(
        dataSource.add(<Product>[stubProduct(id: "1")]),
        emitsInOrder(<ProductList>[
          ProductList([stubProduct(id: "1")])
        ]));
  });

  test('remove', () async {
    dataSource.add(<Product>[stubProduct(id: "1")]);
    dataSource.add(<Product>[stubProduct(id: "2")]);
    await expectLater(
        dataSource.remove(["2"]),
        emitsInOrder(<ProductList>[
          ProductList([stubProduct(id: "1")])
        ]));
  });

  test('getAll', () async {
    dataSource.add(<Product>[stubProduct(id: "1")]);
    dataSource.add(<Product>[stubProduct(id: "2")]);
    await expectLater(
        dataSource.getAll(),
        emitsInOrder(<ProductList>[
          ProductList([stubProduct(id: "1"), stubProduct(id: "2")]),
        ]));
  });

  test('markAsChecked', () async {
    dataSource.add(<Product>[stubProduct(id: "1")]);
    dataSource.add(<Product>[stubProduct(id: "2")]);
    await expectLater(
        dataSource.markAsChecked("1"),
        emitsInOrder(<ProductList>[
          ProductList([stubProduct(id: "1", checked: true), stubProduct(id: "2")]),
        ]));
  });

  test('markAsUnchecked', () async {
    dataSource.add(<Product>[stubProduct(id: "1", checked: true)]);
    dataSource.add(<Product>[stubProduct(id: "2")]);
    await expectLater(
        dataSource.markAsUnchecked("1"),
        emitsInOrder(<ProductList>[
          ProductList([stubProduct(id: "1", checked: false), stubProduct(id: "2")]),
        ]));
  });
}

Product stubProduct(
    {String id = "",
    String name = "",
    String count = "",
    ProductUnit unit = ProductUnit.NONE,
    ProductType type = ProductType.OTHER,
    bool checked = false}
) {
  return Product(id, name, count, unit, type, checked);
}
