import 'package:equatable/equatable.dart';
import 'package:shopping_list/src/constants/Constants.dart';

import '../Lang.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String count;
  final ProductUnit unit;
  final ProductType type;
  final bool checked;

  Product(
      this.id,
      this.name,
      [this.count = Constants.EMPTY,
      this.unit = ProductUnit.NONE,
      this.type = ProductType.OTHER,
      this.checked = false]);

  @override
  List<Object> get props => [id, name];

  @override
  String toString() {
    return 'Product{id: $id, name: $name, count: $count, unit: $unit, type: $type, checked: $checked}';
  }
}

enum ProductUnit { NONE, ITEM, KG, GRAM, LITER }

extension ProductUnitMapper on ProductUnit {
  String toUnitString({bool showEmptyShort = true}) {
    switch (this) {
      case ProductUnit.NONE:
        return lang.productUnit_noneShort(showEmptyShort: showEmptyShort);
        break;
      case ProductUnit.ITEM:
        return lang.productUnit_itemShort();
        break;
      case ProductUnit.KG:
        return lang.productUnit_kgShort();
        break;
      case ProductUnit.GRAM:
        return lang.productUnit_gramShort();
        break;
      case ProductUnit.LITER:
        return lang.productUnit_literShort();
        break;
    }
    return "";
  }
}

enum ProductType {
  FRUITS_AND_VEGETABLES,
  ALCOHOL,
  MEDICINE,
  OFFICE,
  ANIMALS,
  HOUSE,
  CHILD,
  POWDERY,
  CHEMISTRY,
  DESSERT,
  DISH,
  HYGIENE,
  OTHER,
  COFFEE_TEE_CACAO,
  CAN,
  COSMETICS,
  FROZEN,
  AUTO,
  DAIRY,
  BREAD,
  TO_READ,
  PRESERVES,
  SPICES_AND_SAUCES,
  FISH,
  RTV_AGD,
  SWEETS_SNACKS
}

extension ProductTypeMapper on ProductType {
  String toUnitString() {
    switch (this) {
      case ProductType.FRUITS_AND_VEGETABLES:
        return lang.productType_fruitsAndVegetables();
        break;
      case ProductType.ALCOHOL:
        return lang.productType_alcohol();
        break;
      case ProductType.MEDICINE:
        return lang.productType_medicine();
        break;
      case ProductType.OFFICE:
        return lang.productType_office();
        break;
      case ProductType.ANIMALS:
        return lang.productType_animals();
        break;
      case ProductType.HOUSE:
        return lang.productType_house();
        break;
      case ProductType.CHILD:
        return lang.productType_child();
        break;
      case ProductType.POWDERY:
        return lang.productType_powdery();
        break;
      case ProductType.CHEMISTRY:
        return lang.productType_chemistry();
        break;
      case ProductType.DESSERT:
        return lang.productType_dessert();
        break;
      case ProductType.DISH:
        return lang.productType_dish();
        break;
      case ProductType.HYGIENE:
        return lang.productType_hygiene();
        break;
      case ProductType.OTHER:
        return lang.productType_other();
        break;
      case ProductType.COFFEE_TEE_CACAO:
        return lang.productType_coffeeTeeCacao();
        break;
      case ProductType.CAN:
        return lang.productType_can();
        break;
      case ProductType.COSMETICS:
        return lang.productType_cosmetics();
        break;
      case ProductType.FROZEN:
        return lang.productType_frozen();
        break;
      case ProductType.AUTO:
        return lang.productType_auto();
        break;
      case ProductType.DAIRY:
        return lang.productType_dairy();
        break;
      case ProductType.BREAD:
        return lang.productType_bread();
        break;
      case ProductType.TO_READ:
        return lang.productType_toRead();
        break;
      case ProductType.PRESERVES:
        return lang.productType_preservers();
        break;
      case ProductType.SPICES_AND_SAUCES:
        return lang.productType_spicesAndSauces();
        break;
      case ProductType.FISH:
        return lang.productType_fish();
        break;
      case ProductType.RTV_AGD:
        return lang.productType_rtvAgd();
        break;
      case ProductType.SWEETS_SNACKS:
        return lang.productType_sweetsSnacks();
        break;
    }
    return "";
  }
}