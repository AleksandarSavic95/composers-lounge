import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'user_photo_state.dart';

class UserPhotoCubit extends Cubit<UserPhotoState> {
  final AuthService _authService;
  UserPhotoCubit(this._authService) : super(const UserPhotoInitial());

  void uploadPhoto() async {
    emit(UserPhotoUploading(state.photo!));
    String? photoUrl = await _authService.uploadUserPhoto(state.photo!);
    if (photoUrl == null) {
      emit(UserPhotoUploadError(state.photo!));
      return;
    }
    emit(UserPhotoUploaded(photoUrl, state.photo!));
  }

  void setPhoto(File photo) {
    emit(UserPhotoSelected(photo));
  }

  void reset() {
    emit(const UserPhotoInitial());
  }
}
