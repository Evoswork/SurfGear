import 'package:relation/src/relation/event.dart';
import 'package:rxdart/rxdart.dart';

class StreamedStateNS<T> implements EventNS<T> {
  /// Behavior state for updating events
  final BehaviorSubject<T> stateSubject = BehaviorSubject();

  /// current value in stream
  T? get value => stateSubject.valueOrNull;

  @override
  Stream<T> get stream => stateSubject.stream;

  StreamedStateNS(T initialData) {
    accept(initialData);
  }

  StreamedStateNS.from(Stream<T> stream) {
    stateSubject.addStream(stream);
  }

  @override
  Future<T> accept(T data) {
    stateSubject.add(data);
    return stateSubject.stream.first;
  }

  void dispose() {
    stateSubject.close();
  }
}
