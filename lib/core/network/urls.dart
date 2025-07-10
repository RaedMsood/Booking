class AppURL {
  static String get base => 'https://booking.najaz.in';

  static String get baseURL => '$base/api/app';

  static String get logIn => '/auth/check';

  static String get signUp => '/auth/signup';

  static String get checkOtp => '/auth/check_otp';

  static String get resendOtp => '/auth/update_otp';

  static String get logout => '/auth/logout';

  static String get getCities => '/cities';

  static String get getDistricts => '/districts';

  static String get confirmOrder => '/orders/store';

  static String get getOrderDate => '/orders/get_order_data';

  static String get orders => '/orders';

  static String get orderDetails => '/orders/show';

  static String get getAllReviews => '/review/product';

  static String get addReview => '/review';

  static String get addLike => '/review/like';

  static String get dislike => '/review/dislike';
}
