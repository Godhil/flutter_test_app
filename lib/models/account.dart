import 'package:flutter_test_app/enums/accountType.dart';
import 'package:flutter_test_app/enums/currency.dart';

class Account {
  AccountType type;
  String bankAccountNumber;
  double sum;
  Currency currency;
  String name;

  Account(
      this.type, this.bankAccountNumber, this.sum, this.currency, this.name);
}