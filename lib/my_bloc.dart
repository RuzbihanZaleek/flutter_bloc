import 'dart:async';

class MyBloc {
  StreamController<int> streamController = StreamController<int>();

  //get Sink
  StreamSink get sink => streamController.sink;

  //get Stream
  Stream<int> get stream => streamController.stream;
}
