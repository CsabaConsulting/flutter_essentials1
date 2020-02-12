import 'package:daylight/daylight.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'flutter_clock.dart';

class DaylightPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClockState state = FlutterClock.of(context);

    if (state.sunSet == '' || state.rightNow.minute == 0 && state.rightNow.second == 0) {
      final locationSunCalculator = DaylightCalculator(state.daylightLocation);
      final civilSunrise = locationSunCalculator.calculateEvent(
        state.rightNow,
        Zenith.civil,
        EventType.sunrise,
      );
      state.sunRise = DateFormat("HH:mm:ss").format(civilSunrise);
      final civilSunset = locationSunCalculator.calculateEvent(
        state.rightNow,
        Zenith.civil,
        EventType.sunset,
      );
      state.sunSet = DateFormat("HH:mm:ss").format(civilSunset);
    }
    return Text('${state.sunRise} - ${state.sunSet}');
  }
}
