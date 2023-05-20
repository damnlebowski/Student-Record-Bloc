part of 'add_image_bloc.dart';

@immutable
abstract class AddImageEvent {}

class OnImageUpdate extends AddImageEvent {
  final String imagePath;

  OnImageUpdate({required this.imagePath});
}
