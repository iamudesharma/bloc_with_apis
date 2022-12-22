import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_upwork/services/photo_repository.dart';

import '../../../model/photo_model.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoRepository? apiRepository;

  PhotosBloc(this.apiRepository) : super(PhotosLoading()) {
    on<GetPhotosList>((event, emit) async {
      emit(PhotosLoading());
      try {
        final joke = await apiRepository!.getPhotos();
        emit(PhotosLoaded(joke));

        // final response = await _apiRepository.getPhotos();
      } catch (e) {
        emit(PhotosError(e.toString()));
      }
    });
  }
}
