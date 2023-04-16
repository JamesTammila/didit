import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<Duration> {
  TimerCubit(Duration duration) : super(duration);

  Timer? timer;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(state - const Duration(seconds: 1));
      if (state == Duration.zero) timer?.cancel();
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}