import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/labs/data/model/get_labs_model.dart';
import 'package:flexedu/features/labs/features/cubit/labs_state.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';

class LabsCubit extends Cubit<LabsState> {
  LabsCubit() : super(LabsInitial());

  static LabsCubit get(context) => BlocProvider.of(context);

  bool isDetails = false;

  changeDetails() {
    isDetails = !isDetails;
    emit(ChangeIndexState());
  }

  GetAllLabs? labs;
  getLabs() {
    emit(GetLabsLoadingState());
    DioHelper.postData(path: ApiUrls.GET_LABS, data: {
      "take": 5,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0
    }).then((value) {
      labs = GetAllLabs.fromJson(value.data);
      emit(GetLabsSuccessState());
    }).catchError((error) {
      emit(GetLabsErrorState());
    });
  }

  GetLabTests? labTests;
  getLabsTestsById(id) {
    emit(GetLabsTestsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 5,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0,
      "labIdOrMedicalTestId": id
    }).then((value) {
      labTests = GetLabTests.fromJson(value.data);
      emit(GetLabsTestsSuccess());
    }).catchError((error) {
      emit(GetLabsTestsError());
    });
  }
}
