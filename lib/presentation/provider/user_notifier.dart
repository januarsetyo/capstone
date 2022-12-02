import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/entities/user.dart';
import 'package:capstone/domain/usecases/create_comments.dart';
import 'package:capstone/domain/usecases/create_profile_picture.dart';
import 'package:capstone/domain/usecases/get_comments_by_id.dart';
import 'package:capstone/domain/usecases/get_profile_picture_by_id.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class UserNotifier extends ChangeNotifier {
  final CreateProfilePicture createProfilePicture;
  final GetProfilePictureById getProfilePictureById;

  UserNotifier(this.createProfilePicture, this.getProfilePictureById);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _profilePictureMessage = '';
  String get profilePictureMessage => _profilePictureMessage;

  dynamic _userById;
  dynamic get userById => _userById;

  String _message = '';
  String get message => _message;

  Future<void> fetchCreateProfilePicture(String userId, String imageUrl) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await createProfilePicture.execute(userId, imageUrl);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _profilePictureMessage = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fetchProfilePictureById(String userId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getProfilePictureById.execute(userId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      if (data is User) {}
      _userById = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
