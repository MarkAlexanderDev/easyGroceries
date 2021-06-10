enum Flavor {
  DEV,
  BETA,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'dev';
      case Flavor.BETA:
        return 'beta';
      default:
        return 'title';
    }
  }
}
