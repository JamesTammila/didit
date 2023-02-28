import 'package:flutter_bloc/flutter_bloc.dart';

class PagerCubit extends Cubit<int> {
  PagerCubit() : super(0);

  void set(int i) => emit(i);
}