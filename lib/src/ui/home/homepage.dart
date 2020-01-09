import 'package:flutter/material.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';
import 'package:shopping_list/src/ui/home/bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageBloc bloc = HomePageBloc(ShoppingListRepositoryImpl());

  @override
  void initState() {
    bloc.load();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: getView());
  }

  Widget getView() {
    return new StreamBuilder<Resource<ProductList>>(
        stream: bloc.state,
        builder: (context, stream) {
          var state = stream.data;
          if (state.loading) {
            return new Center(child: CircularProgressIndicator());
          } else {
            return new ListView.builder(
                itemCount: state.data.products.length,
                itemBuilder: (context, int position) {
              return getRow(state.data.products, position);
            });
          }
        });
  }

  Widget getRow(List<Product> products, int position) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
          products[position].name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
    );
  }
}
