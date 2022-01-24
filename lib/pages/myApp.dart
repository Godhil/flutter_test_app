import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_test_app/models/kladr.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      title: _title,
      home: const MyStatefulWidget(restorationId: 'main'),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with RestorationMixin {

  String _string = 'Выбрать дату';

  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2027),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
    _string = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
        _string = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  List<Kladr> _kladrs = <Kladr>[];

  /*
    Kladr("code", "name", "fullName", "okato", "postIndex1"),
    Kladr("code", "name2", "fullName2", "okato", "postIndex2"),
    Kladr("code", "name3", "fullName3", "okato", "postIndex3"),
    Kladr("code", "name4", "fullName4", "okato", "postIndex4"),
    Kladr("code", "name5", "fullName5", "okato", "postIndex5"),
    Kladr("code", "name6", "fullName6", "okato", "postIndex6"),
    Kladr("code", "name7", "fullName7", "okato", "postIndex7"),
    Kladr("code", "name8", "fullName8", "okato", "postIndex8"),
    Kladr("code", "name9", "fullName9", "okato", "postIndex9"),
    Kladr("code", "name10", "fullName10", "okato", "postIndex10"),
    Kladr("code", "name11", "fullName11", "okato", "postIndex11"),
    Kladr("code", "name12", "fullName12", "okato", "postIndex12"),
     */

  Widget _dialogBuilder(BuildContext context, Kladr kladr){
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(8),
      titlePadding: const EdgeInsets.all(4),
      title: Text(kladr.fullName),
      children: [
        Text('Код ОКАТО: ${kladr.okato}'),
        Text('Индекс: ${kladr.postIndex}'),
      ],
    );
  }

  Widget _kladrItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onDoubleTap: () => showDialog(
          context: context,
          builder: (context) => _dialogBuilder(context, _kladrs[index])
      ),
      child: Container(
        color: index % 2 > 0 ? Colors.amber : null,
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              /*1*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _kladrs[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _kladrs[index].fullName,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            /*3*/
            Icon(
              Icons.streetview,
              color: Colors.red[500],
            ),
            Text('ОКАТО: ${ _kladrs[index].okato}'),
          ],
        ),
      )
    );
  }

  bool showGrid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Container(
            padding: const EdgeInsets.only(top: 68, left: 36, bottom: 0),
            //height: 200,
            alignment: Alignment.center,
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    _restorableDatePickerRouteFuture.present();
                  },
                  child: Text(_string),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showGrid = true;
                    });
                  },
                  autofocus: false,
                  clipBehavior: Clip.hardEdge,
                  child: const Text('Load Kladrs'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showGrid = false;
                    });
                  },
                  autofocus: false,
                  clipBehavior: Clip.hardEdge,
                  child: const Text('Hide Kladrs'),
                )
              ]
            )
          ),
          showGrid ? FutureBuilder(
            future: http.get(
              Uri.https('tender.otc.ru', '/microservices-tender/Tender/api/Dictionary/GetRegionsKladrList'),
              headers: {
                'Content-type' : 'application/json',
                'Accept': 'application/json',
              },
            ),
            builder: (context, snapshot) {
              if (showGrid && snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as http.Response;
                _kladrs = _loadKladrs(response.body);
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _kladrs.length,
                    itemBuilder: _kladrItemBuilder,
                  )
                );
              } else {
                return const Text('');
              }
            },
          ) : const Text('')
        ],
      ),
    );
  }

  _loadKladrs(String apiResponse)  {
    List<Kladr> result = <Kladr>[];
    Iterable kladrs = json.decode(apiResponse);
    kladrs.forEach((element) {
      result.add(Kladr.fromJson(element));
    });
    return result;
  }
}
