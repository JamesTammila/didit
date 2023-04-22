import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<Duration> {
  TimerCubit(String date, this.onZero)
      : super(DateTime.parse(date)
            .add(const Duration(hours: 1))
            .difference(DateTime.now()));

  final Function onZero;
  Timer? timer;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state > Duration.zero){
        emit(state - const Duration(seconds: 1));
      } else {
        timer?.cancel();
        onZero();
      }
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}