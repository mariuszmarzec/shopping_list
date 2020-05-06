abstract class Lang {

  String appName();
  String homeScreenTitle();
  String newProduct();
  String newProduct_ProductNameLabel();
  String newProduct_Count();
  String productUnit_noneShort({bool showEmptyShort = true});
  String productUnit_itemShort();
  String productUnit_kgShort();
  String productUnit_gramShort();
  String productUnit_literShort();
  String productType_fruitsAndVegetables();
  String productType_alcohol();
  String productType_medicine();
  String productType_office();
  String productType_animals();
  String productType_house();
  String productType_child();
  String productType_powdery();
  String productType_chemistry();
  String productType_dessert();
  String productType_dish();
  String productType_hygiene();
  String productType_other();
  String productType_coffeeTeeCacao();
  String productType_can();
  String productType_cosmetics();
  String productType_frozen();
  String productType_auto();
  String productType_dairy();
  String productType_bread();
  String productType_toRead();
  String productType_preservers();
  String productType_spicesAndSauces();
  String productType_fish();
  String productType_rtvAgd();
  String productType_sweetsSnacks();
}

class LangPL extends Lang {
  @override
  String appName() => "Lista zakupów";

  @override
  String homeScreenTitle() => "Lista zakupów";

  @override
  String newProduct() => "Dodaj produkt";

  @override
  String newProduct_ProductNameLabel() => "Nazwa produktu";

  @override
  String newProduct_Count() => "Ilość";

  @override
  String productUnit_gramShort() => "g";

  @override
  String productUnit_itemShort() => "szt.";

  @override
  String productUnit_kgShort() => "kg";

  @override
  String productUnit_literShort() => "l";

  @override
  String productUnit_noneShort({bool showEmptyShort = true}) {
    return showEmptyShort ? "" : "brak";
  }

  @override
  String productType_fruitsAndVegetables() => "Owoce i warzywa";

  @override
  String productType_alcohol() => "Alkohol";

  @override
  String productType_medicine() => "Lekarstwa";

  @override
  String productType_office() => "Artykuły biurowe";

  @override
  String productType_animals() => "Artykuły dla zwierząt";

  @override
  String productType_house() => "Artykuły domowe";

  @override
  String productType_child() => "Dla dzieci";

  @override
  String productType_powdery() => "Sypkie";

  @override
  String productType_chemistry() => "Chemia";

  @override
  String productType_dessert() => "Desery";

  @override
  String productType_dish() => "Potrawy";

  @override
  String productType_hygiene() => "Higiena";

  @override
  String productType_other() => "Inne";

  @override
  String productType_coffeeTeeCacao() => "Kawa, herbata, kakao";

  @override
  String productType_can() => "Zapuszkowane";

  @override
  String productType_cosmetics() => "Kosmetyki";

  @override
  String productType_frozen() => "Mrożonki";

  @override
  String productType_auto() => "Motoryzacja";

  @override
  String productType_dairy() => "Nabiał";

  @override
  String productType_bread() => "Chleb";

  @override
  String productType_toRead() => "Książki, gazety, czasopisma";

  @override
  String productType_preservers() => "Konserwy";

  @override
  String productType_spicesAndSauces() => "Przyprawy i sosy";

  @override
  String productType_fish() => "Ryby";

  @override
  String productType_rtvAgd() => "RTV, AGD";

  @override
  String productType_sweetsSnacks() => "Słodycze i przekąski";
}

Lang lang = new LangPL();