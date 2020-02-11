import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFlutterClock(title: 'Flutter Clock'),
    );
  }
}

class MyFlutterClock extends StatefulWidget {
  MyFlutterClock({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<MyFlutterClock> {
  var _date = '';
  var _time = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      var rightNow = DateTime.now();
      const locale = 'en-US';  // Localizations.localeOf(context).toString();
      _date = DateFormat.yMMMd(locale).format(rightNow);
      _time = DateFormat('hh:mm:ss').format(rightNow);
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: rightNow.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$_time'),
              Text('$_date'),
            ],
          ),
        ),
      ),
    );
  }
}
