class ApiConstants {
  // ===== Base URL =====
  static const String baseUrl = 'https://fruits.sys-web.net/api';

  // ===== Auth Headers =====
  static const String clientId = '9bcfcd34-35b6-4349-97c5-562d50537e70';
  static const String clientSecret = '6BvEFcTiIttVtItPNt4SNJfGlfD0znbzen69k2Vz';

  // ===== User =====
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String updateProfile = '/update_profile';
  static const String deleteUser = '/user_delete';
  static const String changePassword = '/change_password';
  static const String forgetPassword = '/forget_pass_user';
  static const String contactUs = '/contact_us';
  static const String userFavorite = '/user_favorite';

  // ===== Products =====
  static const String products = '/products';
  static const String vendorProducts = '/get_vendor_products';

  // ===== Vendors =====
  static const String vendors = '/getvendors';

  static const String slider = '/advertising/t/ar/0';
  static const String categories = '/categories/get_with_sub/ar/0/0';
  static const String userOrders = '/user_orders';

  // ===== Orders =====
  static const String countries = '/countries';
  static const String cities = '/cities';
  static const String cancelOrder = '/cancel_order';
  static const String confirmCancelOrder = '/confirm_cancel_order';
  static const String citiesDeliveryPrice = '/getcities_deliveryprice';
  static const String cityPrice = '/get_city_price';
  static const String getSocialMedia = '/get_social_media';

  // ===== Coupons =====
  static const String checkCoupon = '/coupons/check';

  // ===== Static Pages =====
  static const String aboutUs = '/about-us';
  static const String conditions = '/conditions';
}
