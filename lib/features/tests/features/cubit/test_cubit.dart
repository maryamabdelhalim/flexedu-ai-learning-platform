import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/search/features/screens/get_search_data.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  static TestCubit get(context) => BlocProvider.of(context);

  bool isDetails = false;

  changeDetails() {
    isDetails = !isDetails;
    emit(ChangeIndexState());
  }

  GetLabTests? tests;
  getLabsTests() {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 1000,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0,
    }).then((value) {
      tests = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? labTests;

  getLabsTestsById(id) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 1000,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0,
      "labIdOrMedicalTestId": id
    }).then((value) {
      labTests = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? labTestsByCategory;
  getLabsTestsByCategory(id) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 1000,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0,
      "section": id
    }).then((value) {
      labTestsByCategory = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? searchData;
  GetSearchData(id) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 1000,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0,
      "section": id
    }).then((value) {
      labTestsByCategory = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }
}
