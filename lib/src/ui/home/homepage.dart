import 'package:flutter/material.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/model/ProductList.dart';
import 'package:shopping_list/src/model/Resource.dart';
import 'package:shopping_list/src/ui/add/AddProductPage.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';
import 'package:shopping_list/src/ui/home/bloc.dart';

import '../../Lang.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageBloc bloc =
      HomePageBloc(ShoppingListRepositoryImpl(dataSource));

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
      body: getView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProductPage(title: lang.newProduct())),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget getView() {
    return new StreamBuilder<Resource<ProductList>>(
        stream: bloc.state,
        builder: (context, stream) {
          var state = stream.data;
          if (state == null || state.loading) {
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
    var product = products[position];
    return new Row(children: [
      Flexible(
          child: CheckboxListTile(
        title: Text(product.name),
        value: product.checked,
        onChanged: (bool isChecked) {
          setState(() {
            if (isChecked) {
              bloc.check(product);
            } else {
              bloc.uncheck(product);
            }
          });
        },
      )),
      GestureDetector(
        onTap: () {
          bloc.onRemoveButtonClick(product);
        }, // handle your image tap here
        child: Icon(
          Icons.remove_shopping_cart,
          size: 24.0,
        ),
      )
    ]);
  }
}
