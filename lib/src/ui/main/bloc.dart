import 'package:rxdart/rxdart.dart';

class HomePageBloc {

  final initialState = Iterable.empty();
  final PublishSubject<String> _event = new PublishSubject<String>();

  Observable<List<String>> _state;

  HomePageBloc() {
    _state = Observable<String>.merge([_event]).scan(
            (List<String> current, String newProduct, int index)
        => new List.from(current) + [newProduct], List());
  }

  Observable<List<String>> get state => _state;

  addProduct() {
    _event.add("Nowy produkt");
  }

  dispose() async {
    _event.close();
  }
}

HomePageBloc bloc = HomePageBloc();