import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'note_book_state.dart';

class NoteBookCubit extends Cubit<NoteBookState> {
  NoteBookCubit() : super(NoteBookState());
}
