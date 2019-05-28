abstract class Lang {

  String appName();
  String homeScreenTitle();
}

class LangPL extends Lang {
  @override
  String appName() => "Lista zakupów";

  @override
  String homeScreenTitle() => "Lista zakupów";

}

Lang lang = new LangPL();