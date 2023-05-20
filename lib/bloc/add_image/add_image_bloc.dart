import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(AddImageInitial('x')) {
    on<OnImageUpdate>((event, emit) {
      emit(AddImageState(event.imagePath));
    });
  }
}
