/// API endpoint constants.
abstract class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';

  // User
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';

  // Products
  static const String products = '/products';
  static String productDetail(String id) => '/products/$id';

  // Orders
  static const String orders = '/orders';
  static String orderDetail(String id) => '/orders/$id';
}
