enum Flavor {
  DEV,
  BETA,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Foodz dev';
      case Flavor.BETA:
        return 'Foodz beta';
      default:
        return 'title';
    }
  }
}
