import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = 20;
  bool isRunning = false;
  int totalPomodoro = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalSeconds = twentyFiveMinutes;
        totalPomodoro = totalPomodoro + 1;
        isRunning = false;
        timer.cancel();
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
    });
  }

  String timeFormat(int sec) {
    final minutes = sec ~/ 60;
    final seconds = sec % 60;
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                timeFormat(totalSeconds),
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      iconSize: 80,
                      color: Theme.of(context).cardColor,
                      icon: isRunning
                          ? const Icon(Icons.pause_circle_rounded)
                          : const Icon(
                              Icons.play_circle_rounded,
                            ),
                    ),
                    IconButton(
                      onPressed: onResetPressed,
                      iconSize: 80,
                      color: Theme.of(context).cardColor,
                      icon: const Icon(Icons.remove_circle_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoro',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoro',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
