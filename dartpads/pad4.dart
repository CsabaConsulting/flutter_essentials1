import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  var _rightNow = DateTime.now();
  int _tz = 0;
  Timer _timer;

  void _incrementTimezone() {
    setState(() {
      _tz++;
    });
  }

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_rightNow',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
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
