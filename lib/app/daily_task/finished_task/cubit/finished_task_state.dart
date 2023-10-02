import 'package:flutter/material.dart';
import 'package:just_notes/app/daily_task/models/finished_task_model.dart';

@immutable
class FinishedTaskState {
  final List<FinishedTaskModel> documents;

  final bool isLoading;

  final String errorMessage;

  const FinishedTaskState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMessage,
  });
}
