import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'daily_task_state.dart';

class DailyTaskCubit extends Cubit<DailyTaskState> {
  DailyTaskCubit()
      : super(const DailyTaskState(
          documents: [],
          isLoading: false,
          errorMassage: '',
        ));
}
