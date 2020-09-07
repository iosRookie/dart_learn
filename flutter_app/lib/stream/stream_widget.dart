import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StreamWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StreamWidgetState();
  }
}

class StreamWidgetState extends State<StreamWidget> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamWidget"),
      ),
      body: StreamBuilder(
        initialData: _counter,
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text("You hit me: ${snapshot.data} times");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _streamController.sink.add(++_counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
