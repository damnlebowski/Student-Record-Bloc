part of 'image_bloc.dart';

class ImageState {
  String? imgPath;
  ImageState(this.imgPath);
}

class ImageInitial extends ImageState {
  ImageInitial() : super('');
}
