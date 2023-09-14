part of 'note_book_cubit.dart';

@immutable
class NoteBookState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const NoteBookState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
