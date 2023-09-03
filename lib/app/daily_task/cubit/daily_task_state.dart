part of 'daily_task_cubit.dart';

@immutable
class DailyTaskState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMassage;

  const DailyTaskState(
    {
    required this.documents,
    required this.isLoading,
    required this.errorMassage, 
  });
}
