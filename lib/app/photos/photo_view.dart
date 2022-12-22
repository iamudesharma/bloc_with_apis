// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_upwork/app/photos/bloc/photos_bloc.dart';
import 'package:test_upwork/model/photo_model.dart';
import 'package:test_upwork/services/photo_services.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  void initState() {
    // _photosBloc.add(GetPhotosList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PhotosBloc(RepositoryProvider.of<PhotoService>(context))
            ..add(GetPhotosList()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: BlocBuilder<PhotosBloc, PhotosState>(
          builder: (context, state) {
            if (state is PhotosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PhotosLoaded) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.PhotosModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(state.PhotosModel[index].title!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoDetailsView(
                                photoModel: state.PhotosModel[index]),
                          ),
                        );
                      },
                    );
                  });
            }
            if (state is PhotosError) {
              return Center(
                child: Text(state.message.toString()),
              );
            }
            return Container();

            // if (state is PhotosInitial) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else if (state is PhotosLoading) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else if (state is PhotosLoaded) {
            //   return ListView.builder(
            //     itemCount: state.PhotosModel.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container();
            //     },
            //   );
            // } else if (state is PhotosError) {
            //   return Container();
            // } else {
            //   return Container();
            // }
          },
        ),
      ),
    );
  }
}

class PhotoDetailsView extends StatelessWidget {
  const PhotoDetailsView({
    Key? key,
    required this.photoModel,
  }) : super(key: key);
  final PhotoModel photoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                photoModel.thumbnailUrl!,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 20,
          ),
          Text(photoModel.title!),
          SizedBox(
            height: 20,
          ),
          Text(
            photoModel.url!,
          ),
        ],
      ),
    );
  }
}
