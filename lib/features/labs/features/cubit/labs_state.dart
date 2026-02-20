abstract class LabsState {}

class LabsInitial extends LabsState {}

class ChangeIndexState extends LabsState {}

class GetLabsLoadingState extends LabsState {}

class GetLabsSuccessState extends LabsState {}

class GetLabsErrorState extends LabsState {}

class GetLabsTestsLoading extends LabsState {}

class GetLabsTestsSuccess extends LabsState {}

class GetLabsTestsError extends LabsState {}
