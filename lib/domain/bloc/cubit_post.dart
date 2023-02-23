import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<int> {
  PostCubit() : super(0);

  void swipePage(int i) => emit(i);
}