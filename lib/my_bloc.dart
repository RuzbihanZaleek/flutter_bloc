import 'dart:async';

class MyBloc {
  final StreamController<int> _stateStreamController = StreamController<int>();

  //get Sink
  StreamSink get stateStreamSink => _stateStreamController.sink;

  //get Stream
  Stream<int> get stateStream => _stateStreamController.stream;
}
