part of 'note_book_cubit.dart';

@immutable
class NoteBookState {
  final List<NoteBookModel> documents;
  final bool isLoading;
  final String errorMessage;

  const NoteBookState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMessage,
  });
}



//  Future<void> addNote(String title, String text) async {
//     try {
//       await FirebaseFirestore.instance.collection('notebook').add(
//         {'title': title, 'text': text},
//       );
//       emit(const NoteBookState(
//         documents: [],
//         errorMessage: '',
//         isLoading: true,
//       ));
//     } catch (error) {
//       emit(const NoteBookState(
//         documents: [],
//         isLoading: false,
//         errorMessage: 'error',
//       ));
//     }
//   }