import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';
import 'package:shopping_list/src/ui/home/bloc.dart';

class MockShoppingListRepository extends Mock implements ShoppingListRepository {}

void main() {
  HomePageBloc bloc;
  ShoppingListRepository repository;
  setUp(() {
    repository = MockShoppingListRepository();
    bloc = HomePageBloc(repository);
  });

  tearDown(() {
    bloc.dispose();
  });

  test('initial state is correct', () {
    expectLater(bloc.state, emitsInOrder(<Matcher>[
      emits(isInstanceOf<HomePageState>())
    ]));
  });
}