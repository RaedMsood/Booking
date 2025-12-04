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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the '--------generalVariables-----------' key

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `View more`
  String get viewMore {
    return Intl.message('View more', name: 'viewMore', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Sharing`
  String get sharing {
    return Intl.message('Sharing', name: 'sharing', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
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

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Show less`
  String get showLess {
    return Intl.message('Show less', name: 'showLess', desc: '', args: []);
  }

  /// `YER`
  String get YER {
    return Intl.message('YER', name: 'YER', desc: '', args: []);
  }

  // skipped getter for the '--------bottombar-----------' key

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Map`
  String get map {
    return Intl.message('Map', name: 'map', desc: '', args: []);
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
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  // skipped getter for the '--------home-----------' key

  /// `Discover our destinations ✈️🌎`
  String get discoverOurDestinations {
    return Intl.message(
      'Discover our destinations ✈️🌎',
      name: 'discoverOurDestinations',
      desc: '',
      args: [],
    );
  }

  /// `Your hotel destination`
  String get yourHotelDestination {
    return Intl.message(
      'Your hotel destination',
      name: 'yourHotelDestination',
      desc: '',
      args: [],
    );
  }

  /// `Hostel`
  String get hostel {
    return Intl.message('Hostel', name: 'hostel', desc: '', args: []);
  }

  /// `Destinations`
  String get destinations {
    return Intl.message(
      'Destinations',
      name: 'destinations',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------search-----------' key

  /// `Find the right place for you`
  String get findTheRightPlaceForYou {
    return Intl.message(
      'Find the right place for you',
      name: 'findTheRightPlaceForYou',
      desc: '',
      args: [],
    );
  }

  /// `You can search by property name and customize your results`
  String get searchSubtitle {
    return Intl.message(
      'You can search by property name and customize your results',
      name: 'searchSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for a hotel`
  String get searchHotelPlaceholder {
    return Intl.message(
      'Search for a hotel',
      name: 'searchHotelPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `No search results`
  String get noSearchResults {
    return Intl.message(
      'No search results',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------filter-----------' key

  /// `Filter`
  String get filterTitle {
    return Intl.message('Filter', name: 'filterTitle', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Room type`
  String get roomType {
    return Intl.message('Room type', name: 'roomType', desc: '', args: []);
  }

  /// `Select room type`
  String get selectRoomType {
    return Intl.message(
      'Select room type',
      name: 'selectRoomType',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Features`
  String get features {
    return Intl.message('Features', name: 'features', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Apply filter`
  String get applyFilter {
    return Intl.message(
      'Apply filter',
      name: 'applyFilter',
      desc: '',
      args: [],
    );
  }

  /// `Clear filters`
  String get clearFilters {
    return Intl.message(
      'Clear filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `Nights`
  String get nights {
    return Intl.message('Nights', name: 'nights', desc: '', args: []);
  }

  /// `Select dates`
  String get selectDates {
    return Intl.message(
      'Select dates',
      name: 'selectDates',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------details-----------' key

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `Unable to open Maps app`
  String get unableToOpenMapsApp {
    return Intl.message(
      'Unable to open Maps app',
      name: 'unableToOpenMapsApp',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Show in map`
  String get showInMap {
    return Intl.message('Show in map', name: 'showInMap', desc: '', args: []);
  }

  /// `Deposit`
  String get deposit {
    return Intl.message('Deposit', name: 'deposit', desc: '', args: []);
  }

  /// `Hotel terms and policies`
  String get hotelTermsAndPolicies {
    return Intl.message(
      'Hotel terms and policies',
      name: 'hotelTermsAndPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Hotel rooms`
  String get hotelRooms {
    return Intl.message('Hotel rooms', name: 'hotelRooms', desc: '', args: []);
  }

  /// `Rooms at`
  String get roomsFor {
    return Intl.message('Rooms at', name: 'roomsFor', desc: '', args: []);
  }

  /// `View details`
  String get viewDetails {
    return Intl.message(
      'View details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  // skipped getter for the '--------myBookings-----------' key

  /// `Reservations`
  String get reservationsTitle {
    return Intl.message(
      'Reservations',
      name: 'reservationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get allFilter {
    return Intl.message('All', name: 'allFilter', desc: '', args: []);
  }

  /// `Current`
  String get currentFilter {
    return Intl.message('Current', name: 'currentFilter', desc: '', args: []);
  }

  /// `Completed`
  String get completedFilter {
    return Intl.message(
      'Completed',
      name: 'completedFilter',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceledFilter {
    return Intl.message('Canceled', name: 'canceledFilter', desc: '', args: []);
  }

  /// `Booking number copied`
  String get bookingCodeCopied {
    return Intl.message(
      'Booking number copied',
      name: 'bookingCodeCopied',
      desc: '',
      args: [],
    );
  }

  /// `Count`
  String get countLabel {
    return Intl.message('Count', name: 'countLabel', desc: '', args: []);
  }

  /// `Add your rating`
  String get addYourRating {
    return Intl.message(
      'Add your rating',
      name: 'addYourRating',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  // skipped getter for the '--------map-----------' key

  /// `Map`
  String get mapTitle {
    return Intl.message('Map', name: 'mapTitle', desc: '', args: []);
  }

  /// `Explore places on the map`
  String get mapHeadline {
    return Intl.message(
      'Explore places on the map',
      name: 'mapHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Use the search tool to locate places easily and quickly.`
  String get mapSubhead {
    return Intl.message(
      'Use the search tool to locate places easily and quickly.',
      name: 'mapSubhead',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------myBookingsDetails-----------' key

  /// `Booking details`
  String get bookingDetailsTitle {
    return Intl.message(
      'Booking details',
      name: 'bookingDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Booking confirmation`
  String get bookingConfirmation {
    return Intl.message(
      'Booking confirmation',
      name: 'bookingConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Booking number`
  String get bookingCodeLabel {
    return Intl.message(
      'Booking number',
      name: 'bookingCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Booking date`
  String get bookingDateLabel {
    return Intl.message(
      'Booking date',
      name: 'bookingDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Booking status`
  String get bookingStatusLabel {
    return Intl.message(
      'Booking status',
      name: 'bookingStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Booking info`
  String get bookingInfo {
    return Intl.message(
      'Booking info',
      name: 'bookingInfo',
      desc: '',
      args: [],
    );
  }

  /// `Adults`
  String get adultsCount {
    return Intl.message('Adults', name: 'adultsCount', desc: '', args: []);
  }

  /// `Children`
  String get childrenCount {
    return Intl.message('Children', name: 'childrenCount', desc: '', args: []);
  }

  /// `Check-in date`
  String get checkInDate {
    return Intl.message(
      'Check-in date',
      name: 'checkInDate',
      desc: '',
      args: [],
    );
  }

  /// `Check-out date`
  String get checkOutDate {
    return Intl.message(
      'Check-out date',
      name: 'checkOutDate',
      desc: '',
      args: [],
    );
  }

  /// `Purchase & cancellation policy`
  String get purchaseAndCancellationPolicy {
    return Intl.message(
      'Purchase & cancellation policy',
      name: 'purchaseAndCancellationPolicy',
      desc: '',
      args: [],
    );
  }

  /// `View venue details`
  String get viewVenueDetails {
    return Intl.message(
      'View venue details',
      name: 'viewVenueDetails',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------hotelBooking-----------' key

  /// `Hotel booking`
  String get hotelBookingTitle {
    return Intl.message(
      'Hotel booking',
      name: 'hotelBookingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your booking date`
  String get yourBookingDate {
    return Intl.message(
      'Your booking date',
      name: 'yourBookingDate',
      desc: '',
      args: [],
    );
  }

  /// `Select booking date`
  String get selectBookingDate {
    return Intl.message(
      'Select booking date',
      name: 'selectBookingDate',
      desc: '',
      args: [],
    );
  }

  /// `Check-in`
  String get checkIn {
    return Intl.message('Check-in', name: 'checkIn', desc: '', args: []);
  }

  /// `Check-out`
  String get checkOut {
    return Intl.message('Check-out', name: 'checkOut', desc: '', args: []);
  }

  /// `Guests information`
  String get guestsSectionTitle {
    return Intl.message(
      'Guests information',
      name: 'guestsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Purpose of stay`
  String get bookingPurpose {
    return Intl.message(
      'Purpose of stay',
      name: 'bookingPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Leisure`
  String get purposeLeisure {
    return Intl.message('Leisure', name: 'purposeLeisure', desc: '', args: []);
  }

  /// `Business`
  String get purposeBusiness {
    return Intl.message(
      'Business',
      name: 'purposeBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get purposeFamily {
    return Intl.message('Family', name: 'purposeFamily', desc: '', args: []);
  }

  /// `Other`
  String get purposeOther {
    return Intl.message('Other', name: 'purposeOther', desc: '', args: []);
  }

  /// `Rooms`
  String get roomsCount {
    return Intl.message('Rooms', name: 'roomsCount', desc: '', args: []);
  }

  /// `Adults`
  String get adults {
    return Intl.message('Adults', name: 'adults', desc: '', args: []);
  }

  /// `Children`
  String get children {
    return Intl.message('Children', name: 'children', desc: '', args: []);
  }

  /// `Increase`
  String get increase {
    return Intl.message('Increase', name: 'increase', desc: '', args: []);
  }

  /// `Decrease`
  String get decrease {
    return Intl.message('Decrease', name: 'decrease', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Please select a booking date`
  String get validationSelectDate {
    return Intl.message(
      'Please select a booking date',
      name: 'validationSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `Please set the number of guests`
  String get validationGuestsRequired {
    return Intl.message(
      'Please set the number of guests',
      name: 'validationGuestsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please set the number of rooms`
  String get validationRoomsRequired {
    return Intl.message(
      'Please set the number of rooms',
      name: 'validationRoomsRequired',
      desc: '',
      args: [],
    );
  }

  /// `At least one adult is required`
  String get validationMinOneAdult {
    return Intl.message(
      'At least one adult is required',
      name: 'validationMinOneAdult',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get calendarToday {
    return Intl.message('Today', name: 'calendarToday', desc: '', args: []);
  }

  /// `Clear dates`
  String get calendarClear {
    return Intl.message(
      'Clear dates',
      name: 'calendarClear',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get calendarApply {
    return Intl.message('Apply', name: 'calendarApply', desc: '', args: []);
  }

  /// `Personal information`
  String get personalInfoTitle {
    return Intl.message(
      'Personal information',
      name: 'personalInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get personOne {
    return Intl.message('Person', name: 'personOne', desc: '', args: []);
  }

  /// `People`
  String get personTwo {
    return Intl.message('People', name: 'personTwo', desc: '', args: []);
  }

  /// `People`
  String get personOther {
    return Intl.message('People', name: 'personOther', desc: '', args: []);
  }

  // skipped getter for the '--------booking-----------' key

  /// `Booking confirmation`
  String get confirmationSectionTitle {
    return Intl.message(
      'Booking confirmation',
      name: 'confirmationSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rooms`
  String get roomsShort {
    return Intl.message('Rooms', name: 'roomsShort', desc: '', args: []);
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Deposit`
  String get depositSectionTitle {
    return Intl.message(
      'Deposit',
      name: 'depositSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pay deposit`
  String get payDeposit {
    return Intl.message('Pay deposit', name: 'payDeposit', desc: '', args: []);
  }

  /// `Please pay the deposit to confirm the booking`
  String get payDepositNote {
    return Intl.message(
      'Please pay the deposit to confirm the booking',
      name: 'payDepositNote',
      desc: '',
      args: [],
    );
  }

  /// `Guests details`
  String get guestsInfoTitle {
    return Intl.message(
      'Guests details',
      name: 'guestsInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `{adults} person ({children} children)`
  String guestsSummaryFormat(Object adults, Object children) {
    return Intl.message(
      '$adults person ($children children)',
      name: 'guestsSummaryFormat',
      desc: '',
      args: [adults, children],
    );
  }

  /// `Hotel policy:`
  String get hotelPolicyPrefix {
    return Intl.message(
      'Hotel policy:',
      name: 'hotelPolicyPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Deposit amount is strictly non-refundable`
  String get nonRefundablePolicy {
    return Intl.message(
      'Deposit amount is strictly non-refundable',
      name: 'nonRefundablePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Pay deposit`
  String get depositPaymentTitle {
    return Intl.message(
      'Pay deposit',
      name: 'depositPaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Have a discount coupon?`
  String get haveCouponQuestion {
    return Intl.message(
      'Have a discount coupon?',
      name: 'haveCouponQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message('Coupon', name: 'coupon', desc: '', args: []);
  }

  /// `Enter coupon`
  String get enterCoupon {
    return Intl.message(
      'Enter coupon',
      name: 'enterCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verifyCoupon {
    return Intl.message('Verify', name: 'verifyCoupon', desc: '', args: []);
  }

  /// `Discount`
  String get couponDiscount {
    return Intl.message('Discount', name: 'couponDiscount', desc: '', args: []);
  }

  /// `Payment methods`
  String get paymentMethods {
    return Intl.message(
      'Payment methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get cost {
    return Intl.message('Cost', name: 'cost', desc: '', args: []);
  }

  /// `Total`
  String get grandTotal {
    return Intl.message('Total', name: 'grandTotal', desc: '', args: []);
  }

  /// `Deposit`
  String get depositAmount {
    return Intl.message('Deposit', name: 'depositAmount', desc: '', args: []);
  }

  /// `Remaining after deposit`
  String get remainingAfterDeposit {
    return Intl.message(
      'Remaining after deposit',
      name: 'remainingAfterDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get payAction {
    return Intl.message('Pay', name: 'payAction', desc: '', args: []);
  }

  /// `Please select a payment method`
  String get pleaseSelectPaymentMethod {
    return Intl.message(
      'Please select a payment method',
      name: 'pleaseSelectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay the deposit to confirm the booking`
  String get confirmDepositTitle {
    return Intl.message(
      'Pay the deposit to confirm the booking',
      name: 'confirmDepositTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hotel policy: the deposit is strictly non-refundable`
  String get hotelPolicyNote {
    return Intl.message(
      'Hotel policy: the deposit is strictly non-refundable',
      name: 'hotelPolicyNote',
      desc: '',
      args: [],
    );
  }

  /// `You will need to pay the remaining amount to the hotel owner upon arrival`
  String get hotelPaymentNote {
    return Intl.message(
      'You will need to pay the remaining amount to the hotel owner upon arrival',
      name: 'hotelPaymentNote',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------payment-----------' key

  /// `Amount`
  String get amountLabel {
    return Intl.message('Amount', name: 'amountLabel', desc: '', args: []);
  }

  /// `Please enter the amount`
  String get amountValidation {
    return Intl.message(
      'Please enter the amount',
      name: 'amountValidation',
      desc: '',
      args: [],
    );
  }

  /// `The identification number is generated from Al Kuraimi app settings on first setup`
  String get payKuraimiInstruction {
    return Intl.message(
      'The identification number is generated from Al Kuraimi app settings on first setup',
      name: 'payKuraimiInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Identification code`
  String get payKuraimiCodeLabel {
    return Intl.message(
      'Identification code',
      name: 'payKuraimiCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Identification code`
  String get payKuraimiCodeHint {
    return Intl.message(
      'Identification code',
      name: 'payKuraimiCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the identification code`
  String get payKuraimiCodeEmptyError {
    return Intl.message(
      'Please enter the identification code',
      name: 'payKuraimiCodeEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Enter the purchase code generated in the Jawali app`
  String get payJawaliInstruction {
    return Intl.message(
      'Enter the purchase code generated in the Jawali app',
      name: 'payJawaliInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Purchase code`
  String get payJawaliCodeLabel {
    return Intl.message(
      'Purchase code',
      name: 'payJawaliCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Purchase code`
  String get payJawaliCodeHint {
    return Intl.message(
      'Purchase code',
      name: 'payJawaliCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the purchase code`
  String get payJawaliCodeEmptyError {
    return Intl.message(
      'Please enter the purchase code',
      name: 'payJawaliCodeEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Payment`
  String get confirmPayment {
    return Intl.message(
      'Confirm Payment',
      name: 'confirmPayment',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been confirmed successfully, thank you.`
  String get bookingConfirmed {
    return Intl.message(
      'Your booking has been confirmed successfully, thank you.',
      name: 'bookingConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Back to my bookings`
  String get backToMyBookings {
    return Intl.message(
      'Back to my bookings',
      name: 'backToMyBookings',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------profile-----------' key

  /// `Personal information`
  String get personalInfo {
    return Intl.message(
      'Personal information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutApp {
    return Intl.message('About the app', name: 'aboutApp', desc: '', args: []);
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message('Contact us', name: 'contactUs', desc: '', args: []);
  }

  /// `FAQ`
  String get faq {
    return Intl.message('FAQ', name: 'faq', desc: '', args: []);
  }

  /// `Share the app`
  String get shareApp {
    return Intl.message('Share the app', name: 'shareApp', desc: '', args: []);
  }

  // skipped getter for the '--------editProfile-----------' key

  /// `Edit personal information`
  String get editPersonalInfoTitle {
    return Intl.message(
      'Edit personal information',
      name: 'editPersonalInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update your personal information`
  String get editPersonalInfoSubtitle {
    return Intl.message(
      'Update your personal information',
      name: 'editPersonalInfoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------settings-----------' key

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `SIGN OUT`
  String get signOut {
    return Intl.message('SIGN OUT', name: 'signOut', desc: '', args: []);
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

  /// `Change currency`
  String get changeCurrency {
    return Intl.message(
      'Change currency',
      name: 'changeCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Current phone number`
  String get phoneNumberCurrent {
    return Intl.message(
      'Current phone number',
      name: 'phoneNumberCurrent',
      desc: '',
      args: [],
    );
  }

  /// `New phone number`
  String get phoneNumberNew {
    return Intl.message(
      'New phone number',
      name: 'phoneNumberNew',
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

  /// `Do you really want to delete your account? You will lose all related data.`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Do you really want to delete your account? You will lose all related data.',
      name: 'deleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to log out? You will need to log in again to access your data.`
  String get logoutConfirmation {
    return Intl.message(
      'Do you really want to log out? You will need to log in again to access your data.',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------user-----------' key

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
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
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

  /// `Please enter the verification code`
  String get pleaseEnterTheVerificationCode {
    return Intl.message(
      'Please enter the verification code',
      name: 'pleaseEnterTheVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCode {
    return Intl.message(
      'Verification code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message('Log in', name: 'logIn', desc: '', args: []);
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `example@gmail.com`
  String get emailPlaceholder {
    return Intl.message(
      'example@gmail.com',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
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

  /// `Enter your phone number`
  String get phonePlaceholder {
    return Intl.message(
      'Enter your phone number',
      name: 'phonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get governorate {
    return Intl.message('City', name: 'governorate', desc: '', args: []);
  }

  /// `Enter your full name`
  String get fullNamePlaceholder {
    return Intl.message(
      'Enter your full name',
      name: 'fullNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Select governorate`
  String get selectGovernorate {
    return Intl.message(
      'Select governorate',
      name: 'selectGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Amanat Al Asimah`
  String get governorateAmanatAlAsimah {
    return Intl.message(
      'Amanat Al Asimah',
      name: 'governorateAmanatAlAsimah',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameRequired {
    return Intl.message(
      'Name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone is required`
  String get phoneRequired {
    return Intl.message(
      'Phone is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must start with 7 (Yemen)`
  String get phoneMustStartWith7 {
    return Intl.message(
      'Phone number must start with 7 (Yemen)',
      name: 'phoneMustStartWith7',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must not be less than 9 digits`
  String get phoneMustBe9Digits {
    return Intl.message(
      'Phone number must not be less than 9 digits',
      name: 'phoneMustBe9Digits',
      desc: '',
      args: [],
    );
  }

  /// `Please select a governorate`
  String get governorateRequired {
    return Intl.message(
      'Please select a governorate',
      name: 'governorateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email (optional)`
  String get emailOptional {
    return Intl.message(
      'Email (optional)',
      name: 'emailOptional',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate (optional)`
  String get birthdateOptional {
    return Intl.message(
      'Birthdate (optional)',
      name: 'birthdateOptional',
      desc: '',
      args: [],
    );
  }

  /// `Enter birthdate`
  String get enterBirthdate {
    return Intl.message(
      'Enter birthdate',
      name: 'enterBirthdate',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
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

  /// `Continue as guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as guest',
      name: 'continueAsGuest',
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

  /// `Logout successfully`
  String get logoutSuccessfully {
    return Intl.message(
      'Logout successfully',
      name: 'logoutSuccessfully',
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

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Phone number changed successfully.`
  String get phoneNumberUpdatedSuccess {
    return Intl.message(
      'Phone number changed successfully.',
      name: 'phoneNumberUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get accountDeletedSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'accountDeletedSuccess',
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

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later or contact support`
  String get internalServerError2 {
    return Intl.message(
      'Please try again later or contact support',
      name: 'internalServerError2',
      desc: '',
      args: [],
    );
  }

  /// `Feature not supported on the server`
  String get notImplemented {
    return Intl.message(
      'Feature not supported on the server',
      name: 'notImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the app is updated or contact support`
  String get notImplemented2 {
    return Intl.message(
      'Make sure the app is updated or contact support',
      name: 'notImplemented2',
      desc: '',
      args: [],
    );
  }

  /// `Bad gateway`
  String get badGateway {
    return Intl.message('Bad gateway', name: 'badGateway', desc: '', args: []);
  }

  /// `Please try again shortly`
  String get badGateway2 {
    return Intl.message(
      'Please try again shortly',
      name: 'badGateway2',
      desc: '',
      args: [],
    );
  }

  /// `Service unavailable`
  String get serviceUnavailable {
    return Intl.message(
      'Service unavailable',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get serviceUnavailable2 {
    return Intl.message(
      'Please try again later',
      name: 'serviceUnavailable2',
      desc: '',
      args: [],
    );
  }

  /// `Gateway timeout`
  String get gatewayTimeout {
    return Intl.message(
      'Gateway timeout',
      name: 'gatewayTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection or try again later`
  String get gatewayTimeout2 {
    return Intl.message(
      'Check your internet connection or try again later',
      name: 'gatewayTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `HTTP version not supported`
  String get httpVersionNotSupported {
    return Intl.message(
      'HTTP version not supported',
      name: 'httpVersionNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `Please update the app to the latest version`
  String get httpVersionNotSupported2 {
    return Intl.message(
      'Please update the app to the latest version',
      name: 'httpVersionNotSupported2',
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

  /// `Please try again`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to reach the server`
  String get cannotReachServer {
    return Intl.message(
      'Unable to reach the server',
      name: 'cannotReachServer',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection or service URL`
  String get checkInternetOrServiceUrl {
    return Intl.message(
      'Check your internet connection or service URL',
      name: 'checkInternetOrServiceUrl',
      desc: '',
      args: [],
    );
  }

  /// `Receiving data timed out`
  String get receiveTimeout {
    return Intl.message(
      'Receiving data timed out',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later or reduce the data size`
  String get receiveTimeout2 {
    return Intl.message(
      'Please try again later or reduce the data size',
      name: 'receiveTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `Sending data timed out`
  String get sendTimeout {
    return Intl.message(
      'Sending data timed out',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Check your connection and try again`
  String get sendTimeout2 {
    return Intl.message(
      'Check your connection and try again',
      name: 'sendTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `SSL certificate error`
  String get sslError {
    return Intl.message(
      'SSL certificate error',
      name: 'sslError',
      desc: '',
      args: [],
    );
  }

  /// `Ensure your certificate is configured or try again later`
  String get sslError2 {
    return Intl.message(
      'Ensure your certificate is configured or try again later',
      name: 'sslError2',
      desc: '',
      args: [],
    );
  }

  /// `Request was cancelled`
  String get requestCancelled {
    return Intl.message(
      'Request was cancelled',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Retry if the cancellation was unintentional`
  String get requestCancelled2 {
    return Intl.message(
      'Retry if the cancellation was unintentional',
      name: 'requestCancelled2',
      desc: '',
      args: [],
    );
  }

  /// `Invalid service URL`
  String get invalidApiUrl {
    return Intl.message(
      'Invalid service URL',
      name: 'invalidApiUrl',
      desc: '',
      args: [],
    );
  }

  /// `Check the server address (Base URL) and try again`
  String get invalidApiUrl2 {
    return Intl.message(
      'Check the server address (Base URL) and try again',
      name: 'invalidApiUrl2',
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
