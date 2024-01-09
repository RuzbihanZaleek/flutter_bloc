import 'dart:async';

class MyBloc {
  //State Stream Controller
  final StreamController<int> _stateStreamController = StreamController<int>();

  StreamSink get _stateStreamSink => _stateStreamController.sink;

  Stream<int> get stateStream => _stateStreamController.stream;

  //Event Stream Controller
  final StreamController<int> _eventStreamController = StreamController<int>();

  StreamSink get eventStreamSink => _eventStreamController.sink;

  Stream<int> get _eventStream => _eventStreamController.stream;

  MyBloc() {
    _eventStream.listen((event) {
      print(event);
      businessLogic(event);
      _stateStreamSink.add(event);
    });
  }

  void businessLogic(event) {
    event++;
  }
}
