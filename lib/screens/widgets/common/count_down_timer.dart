import 'dart:async';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final String endTime; // Add the endTime parameter

  const CountDownTimer({super.key, required this.endTime});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? _timer;
  Duration _duration = Duration();

  void _startTimer() {
    if (widget.endTime.isEmpty) return _timer?.cancel(); // Check if endTime is empty (optional
    // Calculate duration based on the endTime provided
    final endTime = DateTime.parse(widget.endTime);
    final currentTime = DateTime.now();
    _duration = endTime.difference(currentTime);

    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final seconds = _duration.inSeconds - 1;
        if (seconds < 0) {
          _timer?.cancel();
        } else {
          _duration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Formatting duration to display
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_duration.inMinutes);
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Center(
      child: Text(
          '$minutes:$seconds',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
