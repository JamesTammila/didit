import 'package:flutter_bloc/flutter_bloc.dart';

class MenuFriendsCubit extends Cubit<int> {
  MenuFriendsCubit() : super(0);

  void set(int i) => emit(i);
}