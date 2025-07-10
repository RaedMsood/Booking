// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the '--------generalVariables-----------' key

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `View more`
  String get viewMore {
    return Intl.message(
      'View more',
      name: 'viewMore',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Daily new`
  String get dailyNew {
    return Intl.message(
      'Daily new',
      name: 'dailyNew',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Sharing`
  String get sharing {
    return Intl.message(
      'Sharing',
      name: 'sharing',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Click again to exit!`
  String get clickAgainToExit {
    return Intl.message(
      'Click again to exit!',
      name: 'clickAgainToExit',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------bottombar-----------' key

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `My reservations`
  String get myReservations {
    return Intl.message(
      'My reservations',
      name: 'myReservations',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------confirmOrder-----------' key

  /// `Confirm order`
  String get confirmOrder {
    return Intl.message(
      'Confirm order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Shipping method`
  String get shippingMethod {
    return Intl.message(
      'Shipping method',
      name: 'shippingMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Have a coupon or discount voucher?`
  String get haveACouponOrDiscountVoucher {
    return Intl.message(
      'Have a coupon or discount voucher?',
      name: 'haveACouponOrDiscountVoucher',
      desc: '',
      args: [],
    );
  }

  /// `The total`
  String get theTotal {
    return Intl.message(
      'The total',
      name: 'theTotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery cost`
  String get deliveryCost {
    return Intl.message(
      'Delivery cost',
      name: 'deliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discountOnBill {
    return Intl.message(
      'Discount',
      name: 'discountOnBill',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Please chose a payment method`
  String get pleaseChoseAPaymentMethod {
    return Intl.message(
      'Please chose a payment method',
      name: 'pleaseChoseAPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please chose a shipping method`
  String get pleaseChoseAShippingMethod {
    return Intl.message(
      'Please chose a shipping method',
      name: 'pleaseChoseAShippingMethod',
      desc: '',
      args: [],
    );
  }

  /// `Recipient's phone number`
  String get recipientsPhoneNumber {
    return Intl.message(
      'Recipient\'s phone number',
      name: 'recipientsPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the recipient's phone number`
  String get pleaseEnterTheRecipientsPhoneNumber {
    return Intl.message(
      'Please enter the recipient\'s phone number',
      name: 'pleaseEnterTheRecipientsPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get addressIsRequired {
    return Intl.message(
      'Address is required',
      name: 'addressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Back to home`
  String get backToHome {
    return Intl.message(
      'Back to home',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Successful`
  String get transactionSuccessful {
    return Intl.message(
      'Transaction Successful',
      name: 'transactionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successful placed. Thank you for shopping with us.`
  String get yourOrderHasBeenSuccessfulPlacedThankYouForShoppingWithUs {
    return Intl.message(
      'Your order has been successful placed. Thank you for shopping with us.',
      name: 'yourOrderHasBeenSuccessfulPlacedThankYouForShoppingWithUs',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------profile-----------' key

  // skipped getter for the '--------myOrder-----------' key

  // skipped getter for the '--------reviews-----------' key

  /// `Evaluations`
  String get evaluations {
    return Intl.message(
      'Evaluations',
      name: 'evaluations',
      desc: '',
      args: [],
    );
  }

  /// `Add Rating`
  String get addRating {
    return Intl.message(
      'Add Rating',
      name: 'addRating',
      desc: '',
      args: [],
    );
  }

  /// `Can you leave your review?`
  String get canYouLeaveYourReview {
    return Intl.message(
      'Can you leave your review?',
      name: 'canYouLeaveYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Does the product size fit well?`
  String get doesTheProductSizeFitWell {
    return Intl.message(
      'Does the product size fit well?',
      name: 'doesTheProductSizeFitWell',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment`
  String get AddAComment {
    return Intl.message(
      'Add a comment',
      name: 'AddAComment',
      desc: '',
      args: [],
    );
  }

  /// `Please add a comment`
  String get pleaseAddAComment {
    return Intl.message(
      'Please add a comment',
      name: 'pleaseAddAComment',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get small {
    return Intl.message(
      'Small',
      name: 'small',
      desc: '',
      args: [],
    );
  }

  /// `Appropriate`
  String get appropriate {
    return Intl.message(
      'Appropriate',
      name: 'appropriate',
      desc: '',
      args: [],
    );
  }

  /// `Big`
  String get big {
    return Intl.message(
      'Big',
      name: 'big',
      desc: '',
      args: [],
    );
  }

  /// `Add photos`
  String get addPhotos {
    return Intl.message(
      'Add photos',
      name: 'addPhotos',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------settings-----------' key

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Address Book`
  String get addressBook {
    return Intl.message(
      'Address Book',
      name: 'addressBook',
      desc: '',
      args: [],
    );
  }

  /// `Manage My Account`
  String get manageMyAccount {
    return Intl.message(
      'Manage My Account',
      name: 'manageMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Contact Preferences`
  String get contactPreferences {
    return Intl.message(
      'Contact Preferences',
      name: 'contactPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cache`
  String get clearCache {
    return Intl.message(
      'Clear Cache',
      name: 'clearCache',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Cookie Policy`
  String get privacyAndCookiePolicy {
    return Intl.message(
      'Privacy & Cookie Policy',
      name: 'privacyAndCookiePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Feedback`
  String get ratingAndFeedback {
    return Intl.message(
      'Rating & Feedback',
      name: 'ratingAndFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Connect to Us`
  String get connectToUs {
    return Intl.message(
      'Connect to Us',
      name: 'connectToUs',
      desc: '',
      args: [],
    );
  }

  /// `About Jeeey`
  String get aboutJeeey {
    return Intl.message(
      'About Jeeey',
      name: 'aboutJeeey',
      desc: '',
      args: [],
    );
  }

  /// `SIGN OUT`
  String get signOut {
    return Intl.message(
      'SIGN OUT',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to sign out?`
  String get doYouReallyWantToSignOut {
    return Intl.message(
      'Do you really want to sign out?',
      name: 'doYouReallyWantToSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Application language`
  String get applicationLanguage {
    return Intl.message(
      'Application language',
      name: 'applicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Change currency`
  String get changeCurrency {
    return Intl.message(
      'Change currency',
      name: 'changeCurrency',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------user-----------' key

  /// `Welcome back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to log in to your Jeeey account`
  String get enterYourPasswordToLogInToYourJeeeyAccount {
    return Intl.message(
      'Enter your password to log in to your Jeeey account',
      name: 'enterYourPasswordToLogInToYourJeeeyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Hello my new friend!`
  String get helloMyNewFriend {
    return Intl.message(
      'Hello my new friend!',
      name: 'helloMyNewFriend',
      desc: '',
      args: [],
    );
  }

  /// `Specify your name and password to create a Jeeey account`
  String get specifyYourNameAndPasswordToCreateAJeeeyAccount {
    return Intl.message(
      'Specify your name and password to create a Jeeey account',
      name: 'specifyYourNameAndPasswordToCreateAJeeeyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Phone number or email:`
  String get phoneNumberOrEmail {
    return Intl.message(
      'Phone number or email:',
      name: 'phoneNumberOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get userName {
    return Intl.message(
      'Name:',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password:`
  String get password {
    return Intl.message(
      'Password:',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password`
  String get createANewPassword {
    return Intl.message(
      'Create a new password',
      name: 'createANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in`
  String get resendCodeIN {
    return Intl.message(
      'Resend code in',
      name: 'resendCodeIN',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Code has been send to`
  String get codeHasBeenSendTo {
    return Intl.message(
      'Code has been send to',
      name: 'codeHasBeenSendTo',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Continue with google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Facebook with Continue`
  String get continueWithFacebook {
    return Intl.message(
      'Facebook with Continue',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number or email`
  String get pleaseEnterYourPhoneNumberOrEmail {
    return Intl.message(
      'Please enter your phone number or email',
      name: 'pleaseEnterYourPhoneNumberOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter old password`
  String get pleaseEnterOldPassword {
    return Intl.message(
      'Please enter old password',
      name: 'pleaseEnterOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code`
  String get pleaseEnterTheVerificationCode {
    return Intl.message(
      'Please enter the verification code',
      name: 'pleaseEnterTheVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmYourPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password do not match`
  String get passwordDoNotMatch {
    return Intl.message(
      'Password do not match',
      name: 'passwordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------success-----------' key

  /// `The operation was completed successfully`
  String get successfully {
    return Intl.message(
      'The operation was completed successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `The password has been changed`
  String get thePasswordHasBeenChanged {
    return Intl.message(
      'The password has been changed',
      name: 'thePasswordHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Deleted address successfully`
  String get deletedAddressSuccessfully {
    return Intl.message(
      'Deleted address successfully',
      name: 'deletedAddressSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logout successfully`
  String get logoutSuccessfully {
    return Intl.message(
      'Logout successfully',
      name: 'logoutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Products have been added to the list`
  String get productsHaveBeenAddedToTheList {
    return Intl.message(
      'Products have been added to the list',
      name: 'productsHaveBeenAddedToTheList',
      desc: '',
      args: [],
    );
  }

  /// `The modification has been completed successfully`
  String get theModificationHasBeenCompletedSuccessfully {
    return Intl.message(
      'The modification has been completed successfully',
      name: 'theModificationHasBeenCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The list has been deleted successfully`
  String get theListHasBeenDeletedSuccessfully {
    return Intl.message(
      'The list has been deleted successfully',
      name: 'theListHasBeenDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `A new list has been created successfully`
  String get aNewListHasBeenCreatedSuccessfully {
    return Intl.message(
      'A new list has been created successfully',
      name: 'aNewListHasBeenCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------error-----------' key

  /// `Sorry, no internet connection`
  String get network {
    return Intl.message(
      'Sorry, no internet connection',
      name: 'network',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get network2 {
    return Intl.message(
      'Check your internet connection',
      name: 'network2',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there is an internet issue`
  String get timeout {
    return Intl.message(
      'Sorry, there is an internet issue',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
