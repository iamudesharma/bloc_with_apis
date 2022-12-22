part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosLoading extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosLoaded extends PhotosState {
  final List<PhotoModel> PhotosModel;
  const PhotosLoaded(this.PhotosModel);
  @override
  List<Object> get props => [];
}

class PhotosError extends PhotosState {
  final String? message;
  const PhotosError(this.message);
  @override
  List<Object> get props => [message ?? ""];
}
