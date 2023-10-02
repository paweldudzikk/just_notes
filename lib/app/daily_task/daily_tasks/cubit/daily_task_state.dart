part of 'daily_task_cubit.dart';

@immutable
class DailyTaskState {
  final List<ItemModel> documents;
  final bool isLoading;
  final String errorMassage;

  const DailyTaskState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMassage,
  });
}
