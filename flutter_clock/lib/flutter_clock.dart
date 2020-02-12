import 'dart:async';
import 'package:daylight/daylight.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class _ClockInherited extends InheritedWidget {
  _ClockInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final ClockState data;

  @override
  bool updateShouldNotify(_ClockInherited oldWidget) {
    return true;
  }
}

class FlutterClock extends StatefulWidget {
  // InheritedWidget role of the InheritedWidget pattern
  FlutterClock({
    Key key,
    this.title,
    this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  ClockState createState() => ClockState(clockTitle: this.title);

  static ClockState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ClockInherited>()).data;
  }
}

class ClockState extends State<FlutterClock> {
  DateTime _rightNow = DateTime.now();
  var _sunSet = '';
  var _sunRise = '';
  Timer _timer;
  var _daylightLocation = DaylightLocation(36.7320866, -119.7858041);
  int _tz = 0;
  final String clockTitle;

  DateTime get rightNow => _rightNow;
  DaylightLocation get daylightLocation => _daylightLocation;
  String get sunSet => _sunSet;
  String get sunRise => _sunRise;
  set sunSet(String newSunSet) {
    _sunSet = newSunSet;
  }
  set sunRise(String newSunRise) {
    _sunRise = newSunRise;
  }
  String get title => this.clockTitle;
  get incrementTimezone => _incrementTimezone;

  ClockState({
    this.clockTitle,
  }) : super();

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
      _rightNow = DateTime.now().add(Duration(hours: _tz));
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _rightNow.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _ClockInherited(
      data: this,
      child: widget.child,
    );
  }
}
