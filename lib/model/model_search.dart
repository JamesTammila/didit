import 'package:didit/model/model_friend.dart';
import 'package:didit/model/model_user.dart';

abstract class SearchModel {
  const SearchModel();
}

class RecentSearchModel extends SearchModel {
  final UserModel userModel;

  const RecentSearchModel(this.userModel);
}

class UserSearchModel extends SearchModel {
  final UserModel userModel;

  const UserSearchModel(this.userModel);
}

class FriendSearchModel extends SearchModel {
  final FriendModel friendModel;

  const FriendSearchModel(this.friendModel);
}

class RequestSearchModel extends SearchModel {
  final FriendModel friendModel;

  const RequestSearchModel(this.friendModel);
}

class SentRequestSearchModel extends SearchModel {
  final FriendModel friendModel;

  const SentRequestSearchModel(this.friendModel);
}