import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPagerCubit extends Cubit<int> {
  IntroPagerCubit() : super(0);

  void set(int i) => emit(i);
}