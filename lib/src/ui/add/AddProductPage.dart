import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

import '../../Lang.dart';
import 'AddProductBloc.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddProductPageState createState() => new _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final AddProductBloc bloc =
      AddProductBloc(ShoppingListRepositoryImpl(dataSource), uuid);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: getView());
  }

  Widget getView() {
    return new StreamBuilder<AddProductState>(
        stream: bloc.state,
        initialData: bloc.initialState,
        builder: (context, stream) {
          AddProductState state = stream.data;
          switch (state.step) {
            case AddProductStep.EDIT:
              return createView(state.product);
              break;
            case AddProductStep.ADDING_IN_PROGRESS:
              return new Center(child: CircularProgressIndicator());
              break;
            case AddProductStep.SUCCESS:
              break;
          }
          return Container();
        });
  }

  Widget createView(Product product) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                key: Key("productName"),
                initialValue: product.name,
                decoration: InputDecoration(
                    labelText: lang.newProduct_ProductNameLabel()),
                onChanged: (name) {bloc.setName(name);},
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue: product.count,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: lang.newProduct_Count()),
                      onChanged: (count) {bloc.setCount(count);},
                    ),
                  ),
                  Spacer(),
                  createDropDownUnit(product)
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: createDropDownType(product),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                    child: Text(lang.newProduct_AddButton()),
                    onPressed: () {
                      bloc.onAddButtonClick(() {
                        Navigator.pop(context);
                      });
                    }),
              )
            ])));
  }

  DropdownButton createDropDownUnit(Product product) {
    return DropdownButton<ProductUnit>(
      value: product.unit,
      items: ProductUnit.values
          .map((item) => DropdownMenuItem<ProductUnit>(
                value: item,
                child: Text(item.toUnitString(showEmptyShort: false)),
              ))
          .toList(),
      onChanged: (value) => {bloc.setUnit(value)},
    );
  }

  DropdownButton createDropDownType(Product product) {
    return DropdownButton<ProductType>(
      value: product.type,
      isExpanded: true,
      items: ProductType.values
          .map((item) => DropdownMenuItem<ProductType>(
                value: item,
                child: Text(item.toUnitString()),
              ))
          .toList(),
      onChanged: (value) => {bloc.setType(value)},
    );
  }
}
