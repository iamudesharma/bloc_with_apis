import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:test_upwork/app/photos/bloc/photos_bloc.dart';
import 'package:test_upwork/model/photo_model.dart';
import 'package:test_upwork/services/photo_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('Bloc Success Scenarios: ', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    const PhotosUrl = 'https://jsonplaceholder.typicode.com/photos';
    List<dynamic> _data = [
      {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      },
    ];

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    blocTest<PhotosBloc, PhotosState>(
      'When data is empty',
      setUp: (() {
        return dioAdapter.onGet(
          PhotosUrl,
          (request) => request.reply(200, []),
        );
      }),
      build: () => PhotosBloc(PhotoRepository(dio)),
      wait: const Duration(milliseconds: 500),
      expect: () => [PhotosLoading(), PhotosLoaded(const [])],
    );

    blocTest<PhotosBloc, PhotosState>(
      'When data is not empty',
      setUp: (() {
        return dioAdapter.onGet(
          PhotosUrl,
          (request) => request.reply(200, _data),
        );
      }),
      build: () => PhotosBloc(PhotoRepository(dio)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PhotosLoading(),
        PhotosLoaded([
          PhotoModel(
              albumId: _data[0]['albumId'],
              id: _data[0]['id'],
              title: _data[0]['title'],
              url: _data[0]['url'],
              thumbnailUrl: _data[0]['thumbnailUrl'])
        ])
      ],
    );
  });

  group('Error scenarios: ', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    const PhotosUrl = 'https://products';

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    blocTest<PhotosBloc, PhotosState>(
      'emits failure at initial response is null',
      setUp: (() {
        return dioAdapter.onGet(
          PhotosUrl,
          (request) => request.reply(200, null),
        );
      }),
      build: () => PhotosBloc(PhotoRepository(dio)),
      wait: const Duration(milliseconds: 500),
      expect: () => [PhotosLoading(), PhotosError('unknown error')],
    );
  });
}
