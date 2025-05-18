class ApiUrl {
  static String server = 'https://amiable-abyss-ongvuyvttt8s.vapor-farm-d1.com/api/apps/v1';

  String publicPgmPrices = '$server/current_pgm_price';

  String getProfile = '$server/profile';

  String categories = '$server/categories';

  String categoryProducts(int categoryId, int page) => '$server/catalogue/category/$categoryId/cats?page=$page';
}
