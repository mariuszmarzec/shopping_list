import 'package:equatable/equatable.dart';
import 'package:shopping_list/src/constants/Constants.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String count;
  final ProductUnit unit;
  final ProductType type;

  Product(
      this.id,
      this.name,
      [this.count = Constants.EMPTY,
      this.unit = ProductUnit.NONE,
      this.type = ProductType.OTHER]);

  @override
  List<Object> get props => [id, name];

  @override
  String toString() {
    return 'Product{id: $id, name: $name, count: $count, unit: $unit, type: $type}';
  }
}

enum ProductUnit { NONE, ITEM, KG, GRAM, LITER }

enum ProductType {
  NONE,
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
