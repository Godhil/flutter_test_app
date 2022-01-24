import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/accountWidget.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      title: _title,
      home: const AccountWidget(restorationId: 'main'),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}
