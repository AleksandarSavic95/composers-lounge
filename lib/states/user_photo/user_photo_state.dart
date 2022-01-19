// ignore_for_file: hash_and_equals

part of 'user_photo_cubit.dart';

@immutable
abstract class UserPhotoState {
  final File? photo;

  const UserPhotoState(this.photo);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoState && other.photo == photo;
  }

  @override
  int get hashCode => photo.hashCode;
}

class UserPhotoInitial extends UserPhotoState {
  const UserPhotoInitial() : super(null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoInitial && other.photo == photo;
  }
}

class UserPhotoSelected extends UserPhotoState {
  const UserPhotoSelected(File photo) : super(photo);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoSelected && other.photo == photo;
  }
}

/// Waiting for photo upload result.
class UserPhotoUploading extends UserPhotoState {
  const UserPhotoUploading(File photo) : super(photo);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoUploading && other.photo == photo;
  }
}

class UserPhotoUploaded extends UserPhotoState {
  final String photoUrl;
  const UserPhotoUploaded(this.photoUrl, File photo) : super(photo);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoUploaded && other.photoUrl == photoUrl && other.photo == photo;
  }

  @override
  int get hashCode => photoUrl.hashCode;
}

class UserPhotoUploadError extends UserPhotoState {
  const UserPhotoUploadError(File photo) : super(photo);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPhotoUploadError && other.photo == photo;
  }
}
