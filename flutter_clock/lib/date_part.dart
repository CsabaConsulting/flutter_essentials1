import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'flutter_clock.dart';

class DatePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClockState state = FlutterClock.of(context);
    final locale = Localizations.localeOf(context).toString();
    final dateString = DateFormat.yMMMd(locale).format(state.rightNow);
    return Text('$dateString');
  }
}
