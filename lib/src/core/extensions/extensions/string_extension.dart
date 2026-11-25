import 'package:intl/intl.dart';

extension StringX on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  bool get isPassword => RegExp(r'$').hasMatch(this);
  bool get isUserName => RegExp(r'$').hasMatch(this);

  String reversed(bool reverse) {
    if (reverse) {
      return split('').reversed.join();
    } else {
      return this;
    }
  }

  String? isFullName() {
    if (isEmpty) {
      return 'Enter full name.';
    } else if (split(' ').length == 1 || split(' ').last.isEmpty) {
      return 'Enter valid full name';
    } else {
      return null;
    }
  }

  String? validateKiiBankAccountNumber() {
    if (isEmpty) {
      return 'Enter KiiBank account number';
    } else if (length != 8) {
      return 'Enter a valid KiiBank account number';
    } else {
      return null;
    }
  }

  String? validateKiiBankMobileNumber() {
    if (isEmpty) {
      return 'Enter a mobile number';
    } else if (length <= 5) {
      return 'Enter a number between 5 and 15 digits.';
    } else {
      return null;
    }
  }

  bool get isEmail => RegExp(
          r"^(?=.{1,100}$)[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
      .hasMatch(this);
  bool get isValidCountry => RegExp(r'^\$').hasMatch(this);
  bool get isValidPhoneNo => RegExp(r'^\d{5,15}$').hasMatch(this);

  bool get isValidFullName => RegExp(r'^\$').hasMatch(this);
  bool get isValidRole => RegExp(r'^\$').hasMatch(this);

  /// ^: Asserts the start of the string.
  // (?=.*[a-z]): Positive lookahead assertion for at least one lowercase letter.
  // (?=.*[A-Z]): Positive lookahead assertion for at least one uppercase letter.
  // (?=.*\d): Positive lookahead assertion for at least one digit.
  // (?=.*[@$!%*?&]): Positive lookahead assertion for at least one special character from the specified set @$!%*?&.
  // [A-Za-z\d@$!%*?&]{6,}: Matches any character from the specified set (uppercase letters, lowercase letters, digits, and the specified special characters) for a minimum of 6 characters.
  // $: Asserts the end of the string.

  bool get fullNameRegex =>
      RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$').hasMatch(this);
  // bool get isPassword =>
  //     RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})').hasMatch(this);

  // double get convertToDouble {}
  /// convert string to double
  /// check if string is integer
  /// if true, convert to double
  ///
  /// if false, return 0.0
  /// check if string is double
  /// if true, convert to double
  ///
  /// if false, return 0.0
  double get convertToDouble {
    if (isInteger) {
      return double.parse(this);
    } else if (isDouble) {
      return double.parse(this);
    } else {
      return 0.0;
    }
  }

  /// check if string is integer
  /// if true, return true
  /// if false, return false
  bool get isInteger {
    try {
      int.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// check if string is double
  /// if true, return true
  /// if false, return false
  bool get isDouble {
    try {
      double.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  String get hiddenAmount {
    final int length = this.length;
    return replaceRange(
        0, length, List.generate(length, (index) => 'X').join());
  }

  String get hiddenWalletId {
    final int length = this.length;
    return replaceRange(
        0, length - 4, List.generate(length - 4, (index) => 'X').join());
  }

  String get formatNumber {
    final newValue = replaceAll(',', '');
    final parts = newValue.split('.');

    // Handle integer part of the value
    String integerPart = parts[0].isEmpty ? '0' : parts[0];
    integerPart = NumberFormat('#,###').format(int.parse(integerPart));

    // Handle the decimal part, ensuring it's at most 2 decimal places
    if (parts.length > 1) {
      String decimalPart = parts[1];
      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }
      return '$integerPart.$decimalPart';
    }

    return '$integerPart.00'; // Return the integer part if no decimal part exists
  }
}

extension StringNullX on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullNotEmpty => this != null && this!.trim().isNotEmpty;
}
