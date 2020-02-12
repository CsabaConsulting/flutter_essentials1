import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'flutter_clock.dart';

class TimePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClockState state = FlutterClock.of(context);
    final timeString = DateFormat('hh:mm:ss').format(state.rightNow);
    return Text('$timeString');
  }
}
