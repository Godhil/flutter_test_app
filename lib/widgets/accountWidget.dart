import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/enums/accountType.dart';
import '/enums/currency.dart';
import 'package:flutter_test_app/models/account.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget>
    with RestorationMixin {

  static AccountType accountType = AccountType.All;

  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            Row(
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(accountType == AccountType.All ? Colors.blue : Colors.white54),
                      ),
                      onPressed: () {
                        setState(() {
                          accountType = AccountType.All;
                        });
                      },
                      autofocus: false,
                      clipBehavior: Clip.hardEdge,
                      child: const Text('All'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(accountType == AccountType.Fiat ? Colors.blue : Colors.white54),
                      ),
                      onPressed: () {
                        setState(() {
                          accountType = AccountType.Fiat;
                        });
                      },
                      autofocus: false,
                      clipBehavior: Clip.hardEdge,
                      child: const Text('Fiat'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(accountType == AccountType.Crypto ? Colors.blue : Colors.white54),
                      ),
                      onPressed: () {
                        setState(() {
                          accountType = AccountType.Crypto;
                        });
                      },
                      autofocus: false,
                      clipBehavior: Clip.hardEdge,
                      child: const Text('Crypto'),
                    ),
                  ]
                )
              ]
            ),
            Row(
              children: [
                Column(
                  children: [
                    Visibility(
                    visible: accountType == AccountType.All,
                    child:  Expanded(
                      child: Container(
                        height: 190,
                        child:
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _allAccounts.length,
                          itemExtent: 16.0,
                          itemBuilder: _accountItemBuilder,
                          ),
                        ),

                      )
                    ),
                  ]
                ),
              ],
            ),
            Text(accountType.name)
          ],
        )
      ),
    );
  }

  Widget _accountItemBuilder(BuildContext context, int index) {
    return SizedBox(
      width: 200,
      child: Card(
        child: Column(
          children: [
            Text('${_allAccounts[index].sum}'),
            // ListTile(
            //   title: const Text(
            //     '1625 Main Street',
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            //   subtitle: const Text('My City, CA 99984'),
            //   leading: Icon(
            //     Icons.restaurant_menu,
            //     color: Colors.blue[500],
            //   ),
            // ),
            //const Divider(),
            // ListTile(
            //   title: const Text(
            //     '(408) 555-1212',
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            //   leading: Icon(
            //     Icons.contact_phone,
            //     color: Colors.blue[500],
            //   ),
            // ),
            // ListTile(
            //   title: const Text('costa@example.com'),
            //   leading: Icon(
            //     Icons.contact_mail,
            //     color: Colors.blue[500],
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}

List<Account> _allAccounts = <Account>[
  Account(AccountType.Fiat, '123456789', 126599.0, Currency.RUB, ''),
  Account(AccountType.Fiat, '654654654', 129.59, Currency.EUR, ''),
  Account(AccountType.Fiat, '987987987', 1987.59, Currency.KZT, ''),
  Account(AccountType.Crypto, 'BTC_123456789', 0.568, Currency.BTC, '')
];

