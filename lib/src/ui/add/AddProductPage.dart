import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/src/datasource/DataSource.dart';
import 'package:shopping_list/src/model/Product.dart';
import 'package:shopping_list/src/ui/home/ShoppingListRepository.dart';

import '../../Lang.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddProductPageState createState() => new _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final AddProductBloc bloc =
  AddProductBloc(ShoppingListRepositoryImpl(dataSource));

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
    return Padding(
      padding: EdgeInsets.all(16.0),
        child:
        Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: lang.newProduct_ProductNameLabel()),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: lang.newProduct_Count()))),
                  Spacer(),
                  createDropDownUnit()
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: createDropDownType(),
              )
            ])));
  }

  ProductUnit unit = ProductUnit.values.first;

  DropdownButton createDropDownUnit() {
    return DropdownButton<ProductUnit>(
      value: unit,
      items: ProductUnit.values
          .map((item) => DropdownMenuItem<ProductUnit>(
                value: item,
                child: Text(item.toUnitString(showEmptyShort: false)),
              ))
          .toList(),
      onChanged: (value) => {
        setState(() {
          unit = value;
        })
      },
    );
  }

  ProductType type = ProductType.values.first;

  DropdownButton createDropDownType() {
    return DropdownButton<ProductType>(
      value: type,
      isExpanded: true,
      items: ProductType.values
          .map((item) => DropdownMenuItem<ProductType>(
                value: item,
                child: Text(item.toUnitString()),
              ))
          .toList(),
      onChanged: (value) => {
        setState(() {
          type = value;
        })
      },
    );
  }
}

class AddProductBloc {
  final ShoppingListRepository _repository;

  AddProductBloc(this._repository);

  void dispose() {}
}
