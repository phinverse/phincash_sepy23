import 'dart:async';
import 'package:flutter/material.dart';

class DaysCountDown extends StatefulWidget {
  final DateTime? due;
  final String finishedText;

  DaysCountDown({required this.due, required this.finishedText});

  @override
  _DaysCountDownState createState() => _DaysCountDownState();
}

class _DaysCountDownState extends State<DaysCountDown> {
  Timer? _timer;
  int _daysLeft = 0;

  @override
  void initState() {
    super.initState();
    _updateDaysLeft(); // call once at the start to initialize _daysLeft
    _timer = Timer.periodic(Duration(hours: 1), (Timer t) { // update every hour
      _updateDaysLeft();
    });
  }

  void _updateDaysLeft() {
    if (widget.due != null) {
      final dueDate = widget.due!;
      setState(() {
        _daysLeft = dueDate.difference(DateTime.now()).inDays;
        if (_daysLeft <= 0) {
          _daysLeft = 0;
          if (_timer != null) {
            _timer!.cancel();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _daysLeft > 0 ? '$_daysLeft Days ' : widget.finishedText,
      style: TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}
