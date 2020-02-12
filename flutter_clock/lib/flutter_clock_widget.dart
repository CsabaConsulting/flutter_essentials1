import 'dart:async';
import 'package:daylight/daylight.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'date_part.dart';
import 'daylight_part.dart';
import 'flutter_clock.dart';
import 'time_part.dart';


class FlutterClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClockState state = FlutterClock.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(state.title),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TimePart(),
              DatePart(),
              DaylightPart(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.incrementTimezone,
        tooltip: 'Add an hour',
        child: Icon(Icons.add),
      ),
    );
  }
}
