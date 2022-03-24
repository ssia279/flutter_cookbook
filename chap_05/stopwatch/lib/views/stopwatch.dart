import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stopwatch/views/platform_alert.dart';

class StopWatch extends StatefulWidget {
  static const route = '/stopwatch';
  final String name;
  final String email;

  const StopWatch({Key? key, required this.name, required this.email}) : super (key: key);

  @override
  _StopWatchState createState() {
    return _StopWatchState();
  }
}

class _StopWatchState extends State<StopWatch> {
  int milliseconds = 0; // this and timer properties has to be late because they are initialzed in the initState
  Timer? timer; // will need to restart app since app has been loaded and hotreload will not rerun initState method.
  bool isTicking = false;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  @override
  void initState() {
    //timer = Timer.periodic(Duration(seconds: 1), _onTick);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? name = ModalRoute.of(context)?.settings?.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
          ),
          SizedBox(height: 20),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                onPressed: isTicking ? null : _startTimer,
                child: Text('Start')),
            SizedBox(width: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)
              ),
                onPressed: isTicking ? _lap : null,
                child: Text('Lap')
            ),
            SizedBox(width: 20),
            Builder(
              builder: (context) {
                return TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: isTicking ? () => _stopTimer(context) : null,
                    child: Text('Stop')
                );
              }
            ),
          ],
        );
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
      //seconds == null ? '0' : (seconds! + 1);
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      laps.clear();
      milliseconds += 100;
      isTicking = true;
    });
  }

  void _stopTimer(BuildContext context) {
    timer?.cancel();

    setState(() {
      isTicking = false;
    });

    final totalTime = laps.fold(milliseconds, (int total, lap) => total + lap);
    final alert = PlatformAlert(title: 'Run Completed', message: 'Total Run Time is ${_secondsText(totalTime)}.',);
    //alert.show(context);

    final controller = showBottomSheet(context: context, builder: _buildRunCompleteSheet);
    Future.delayed(Duration(seconds: 5)).then((value) => controller.close());
  }

  Widget _buildRunCompleteSheet(BuildContext context) {
    final totalRunTime = laps.fold(milliseconds, (int total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Run Finished!', style: textTheme.headline6,),
                Text('Total Run Time is ${_secondsText(totalRunTime)}.'),
              ],
            ),
          ),
        ) );
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });

    scrollController.animateTo(itemHeight * laps.length, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        }),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


}