import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:daylight/daylight.dart';


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
  var _sunSet = '';
  var _sunRise = '';
  Timer _timer;
  static const daylightLocation = DaylightLocation(36.7320866, -119.7858041);
  int _tz = 0;

  void _incrementTimezone() {
    setState(() {
      _tz++;
    });
  }

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
      var rightNow = DateTime.now().add(Duration(hours: _tz));
      const locale = 'en-US';  // Localizations.localeOf(context).toString();
      _date = DateFormat.yMMMd(locale).format(rightNow);
      _time = DateFormat('hh:mm:ss').format(rightNow);
      if (_sunSet == '' || _time.endsWith('0:00')) {
        const locationSunCalculator = const DaylightCalculator(daylightLocation);
        final civilSunrise = locationSunCalculator.calculateEvent(
          rightNow,
          Zenith.civil,
          EventType.sunrise,
        );
        _sunRise = DateFormat("HH:mm:ss").format(civilSunrise);
        final civilSunset = locationSunCalculator.calculateEvent(
          rightNow,
          Zenith.civil,
          EventType.sunset,
        );
        _sunSet = DateFormat("HH:mm:ss").format(civilSunset);
      }
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
              Text('$_sunRise - $_sunSet'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTimezone,
        tooltip: 'Add an hour',
        child: Icon(Icons.add),
      ),
    );
  }
}
