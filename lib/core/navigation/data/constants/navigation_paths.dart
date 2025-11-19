class NavigationPaths {
  NavigationPaths._();

  static const String catalog = '/catalog';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String filters = '/filters';
  static const String productDetails = '/product/:id';
  
  static String productDetailsPath(int id) => '/product/$id';
}

