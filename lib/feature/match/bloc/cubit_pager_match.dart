import 'package:flutter_bloc/flutter_bloc.dart';

class MatchPagerCubit extends Cubit<int> {
  MatchPagerCubit() : super(0);

  void swipePage(int i) => emit(i);
}