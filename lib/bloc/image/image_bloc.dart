import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<OnImageChange>((event, emit) {
      return emit(ImageState(event.imgPath));
    });
  }
}
