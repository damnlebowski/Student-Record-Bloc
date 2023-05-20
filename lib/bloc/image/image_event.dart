part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class OnImageChange extends ImageEvent {
  final String imgPath;
  

  OnImageChange({required this.imgPath});
}
