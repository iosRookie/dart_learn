import 'dart:async';

void main() {
  // 创建一个广播Stream，被监听时，只发送done事件
  // print("Stream.empty");
  // Stream.empty().listen((event) {
  //   print(event.toString());
  // }, onDone: () {
  //   print("Done");
  // }, onError: (error) {
  //   print(error.toString());
  // }, cancelOnError: false);

  // print("Stream.value");
  // Stream.value("value stream").listen((value) {
  //   print(value);
  // }, onDone: () {
  //   print("Done");
  // }, onError: (e) {});

  // print("Stream.error");
  // Stream.error("error").listen((value) {
  //   print("value");
  // }, onDone: () {
  //   print("done");
  // }, onError: (e) {
  //   print("error");
  // });

  // print("Stream.fromFuture");
  // Stream.fromFuture(Future.delayed(Duration(seconds: 1), () {
  //   return 1;
  // })).listen((value) {
  //   print(value.toString());
  // }, onDone: () {
  //   print("done");
  // }, onError: (error) {
  //   print("error");
  // });

  // print("Stream.fromFutures");
  // var list = List.generate(10, (value) {
  //   return Future.delayed(Duration(seconds: 10 - value), () {
  //     if (value == 5) {
  //       return Exception("value error");
  //     }
  //     return value;
  //   });
  // });

  // Stream.fromFutures(list).listen((value) {
  //   print(value.toString());
  // }, onDone: () {
  //   print("done");
  // }, onError: (e) {
  //   print(e.toString());
  // }, cancelOnError: false);

  // print("Stream.fromIterable");
  // var list = List.generate(10, (value) {
  //   return Future.delayed(Duration(seconds: 10 - value), () {
  //     return value;
  //   });
  // });
  // Stream.fromIterable(list).listen((value) {
  //   print(value.toString());
  // }, onDone: () {
  //   print("done");
  // }, onError: (obj, str) {
  //   print("error");
  // });

  // print("Stream.periodic");
  // Stream.periodic(Duration(seconds: 2), (count) {
  //   return count;
  // }).listen((onData) {
  //   print(onData.toString());
  // }, onDone: () {
  //   print("done");
  // });

  var list = List.generate(10, (index) {
    return Future.delayed(Duration(seconds: 1), () {
      return index;
    });
  });
  Stream.eventTransformed(Stream.fromIterable(list), (eventSink) {
    return MapSink(eventSink);
  }).listen((value) {
    print(value.toString());
  }, onDone: () {
    print("done");
  }, onError: (e) {
    print(e.toString());
  });
}

class MapSink implements EventSink<Future<int>> {
  EventSink _outputSink;

  MapSink(this._outputSink);

  @override
  void add(Future<int> event) {
    _outputSink.add(event);
  }

  @override
  void addError(Object error, [StackTrace stackTrace]) {
    _outputSink.addError(error, stackTrace);
  }

  @override
  void close() {
    _outputSink.close();
  }
}
