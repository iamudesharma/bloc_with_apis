import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

import '../model/photo_model.dart';

class PhotoService {
  final Dio? dio;

  PhotoService(this.dio);

  Future<List<PhotoModel>> getPhotos() async {
    try {
      debugPrint("Fetching photos");

      final Dio _dio = Dio();

      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/photos');
      debugPrint(response.data.toString());

      return (response.data as List)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
