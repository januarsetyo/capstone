import 'package:capstone/domain/entities/user.dart';
import 'package:capstone/domain/usecases/create_profile_picture.dart';
import 'package:capstone/domain/usecases/delete_profile_picture_by_id.dart';
import 'package:capstone/domain/usecases/get_profile_picture_by_id.dart';
import 'package:capstone/utils/enum_state.dart';
import 'package:flutter/widgets.dart';

class UserNotifier extends ChangeNotifier {
  final CreateProfilePicture createProfilePicture;
  final GetProfilePictureById getProfilePictureById;
  final DeleteProfilePictureById deleteProfilePictureById;

  UserNotifier(this.createProfilePicture, this.getProfilePictureById,
      this.deleteProfilePictureById);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _profilePictureMessage = '';
  String get profilePictureMessage => _profilePictureMessage;

  String _profilePictureDeleteMessage = '';
  String get profilePictureDeleteMessage => _profilePictureDeleteMessage;

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
      if (data is List<User>) {}
      _userById = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fetchDeleteProfilePictureById(String userId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await deleteProfilePictureById.execute(userId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (data) {
      _profilePictureDeleteMessage = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
