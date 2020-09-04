import 'dart:async';

void main(List<String> args) {
  var streamController = StreamController(onListen: () {
    print("listen");
  }, onPause: () {
    print("pause");
  }, onResume: () {
    print("resume");
  }, onCancel: () {
    print("cancel");
  });

  var count = 0;
  Timer.periodic(Duration(seconds: 1), (value) {
    streamController.sink.add(count++);
  });

  print("${streamController.hasListener}");

  var subscription = streamController.stream.listen((value) {
    print("${value}");
  }, onError: (obj, str) {
    print("error");
  }, onDone: () {
    print("done");
  }, cancelOnError: true);
  print("${streamController.hasListener}");

  Future.delayed(Duration(seconds: 5), () {
    subscription.pause();
  });

  Future.delayed(Duration(seconds: 10), () {
    subscription.resume();
  });

  Future.delayed(Duration(seconds: 15), () {
    subscription.cancel();
  });
}
