import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/home_screen/data/model/get_categories.dart';
import 'package:flexedu/features/labs/data/model/get_labs_model.dart';
import 'package:flexedu/features/labs/features/componant/get_labs.dart';
import 'package:flexedu/features/search/data/model/cities_model.dart';
import 'package:flexedu/features/search/features/cubit/search_state.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  bool isDetails = false;

  changeDetails() {
    isDetails = !isDetails;
    emit(ChangeIndexState());
  }

  List<GetCategories>? categories;
  getCategory() async {
    try {
      emit(GetCategoryLoading());
      var response = await DioHelper.getData(endpoint: ApiUrls.GET_CATEGORIES);
      if (response == null) {
        return null;
      }
      final List<dynamic> data = response.data;

      categories = data.map((json) => GetCategories.fromJson(json)).toList();
      emit(GetCategorySuccess());
    } catch (e) {
      emit(GetCategoryError());
    }
  }

  GetLabTests? searchLabsTest;
  getSearchLabTests(
      {String? regionId,
      String? cityId,
      String? districtId,
      String? sectionId,
      String? labIdOrMedicalTestId,
      bool? priceSortingAsc,
      int? searchType}) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "regionId": regionId,
      "cityId": cityId,
      "districtId": districtId,
      "take": 1000,
      "skip": 0,
      "priceSortingAsc": true,
      "section": sectionId,
      "labIdOrMedicalTestId": labIdOrMedicalTestId,
      "searchType": searchType
    }).then((value) {
      searchLabsTest = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? labs;
  getLabs() {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS, data: {
      "take": 100,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0
    }).then((value) {
      labs = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? labsTest;
  getLabsTest() {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_TESTS, data: {
      "take": 100,
      "skip": 0,
      "priceSortingAsc": true,
      "searchType": 0
    }).then((value) {
      labsTest = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? searchLabs;
  getSearchLab({
    String? regionId,
    String? cityId,
    String? districtId,
    String? sectionId,
    String? labIdOrMedicalTestId,
    bool? priceSortingAsc,
  }) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS, data: {
      "regionId": regionId,
      "cityId": cityId,
      "districtId": districtId,
      "take": 100,
      "skip": 0,
      "priceSortingAsc": true,
      "section": sectionId,
      "labIdOrMedicalTestId": labIdOrMedicalTestId,
      "searchType": 0
    }).then((value) {
      searchLabs = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  List<CitiesModel>? cities;
  getCities() async {
    try {
      emit(GetCitiesLoading());
      var response = await DioHelper.getData(endpoint: ApiUrls.GET_CITIES);

      if (response == null) {
        return null;
      }
      final List<dynamic> list = response.data;
      cities = list.map((e) => CitiesModel.fromJson(e)).toList();
      emit(GetCitiesSuccess());
    } catch (e) {
      emit(GetCitiesError());
    }
  }

  List<CitiesModel>? regions;
  getRegions() async {
    try {
      emit(GetCitiesLoading());
      var response = await DioHelper.getData(endpoint: ApiUrls.GET_REGIONS);

      if (response == null) {
        return null;
      }
      final List<dynamic> list = response.data;
      regions = list.map((e) => CitiesModel.fromJson(e)).toList();
      emit(GetCitiesSuccess());
    } catch (e) {
      emit(GetCitiesError());
    }
  }

  List<CitiesModel>? cityByRegion;
  getCityByRegions(String? id) async {
    try {
      emit(GetCitiesLoading());
      var response = await DioHelper.getData(
          endpoint: ApiUrls.GET_CITIES_BY_REGION,
          queryParameters: {"regionId": id});

      if (response == null) {
        return null;
      }
      if (id == null) return;
      final List<dynamic> list = response.data;
      cityByRegion = list.map((e) => CitiesModel.fromJson(e)).toList();
      emit(GetCitiesSuccess());
    } catch (e) {
      emit(GetCitiesError());
    }
  }

  List<CitiesModel>? districts;
  getDistricts() async {
    try {
      emit(GetCitiesLoading());
      var response = await DioHelper.getData(
        endpoint: ApiUrls.GET_DISTRICTS,
      );

      if (response == null) {
        return null;
      }
      final List<dynamic> list = response.data;
      districts = list.map((e) => CitiesModel.fromJson(e)).toList();
      emit(GetCitiesSuccess());
    } catch (e) {
      emit(GetCitiesError());
    }
  }

  List<CitiesModel>? districtsByCity;
  getDistrictsByCity(String? id) async {
    try {
      emit(GetCitiesLoading());
      var response = await DioHelper.getData(
          endpoint: ApiUrls.GET_DISTRICTS_BY_CITY,
          queryParameters: {"cityId": id});
      if (id == null) return;
      if (response == null) {
        return null;
      }

      final List<dynamic> list = response.data;
      districtsByCity = list.map((e) => CitiesModel.fromJson(e)).toList();
      emit(GetCitiesSuccess());
    } catch (e) {
      emit(GetCitiesError());
    }
  }

  GetLabTests? searchByText;
  GetAllLabs? searchLabsByText;
  getSearchLibsByText({String? txt}) {
    emit(GetLabsLoading());
    DioHelper.postData(path: ApiUrls.GET_LABS_BY_TEXT, query: {
      "text": txt,
    }).then((value) {
      searchLabsByText = GetAllLabs.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? searchLabsTestByText;
  getSearchLibsTestByText({
    String? txt,
  }) {
    emit(GetLabsLoading());
    DioHelper.postData(
        path: ApiUrls.GET_TESTS_BY_TEXT,
        query: {"text": txt, "priceSorting": true}).then((value) {
      searchByText = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? searchBackageByText;
  getSearchBackageByText({
    String? txt,
  }) {
    emit(GetLabsLoading());
    DioHelper.postData(
        path: ApiUrls.GET_PACKAGE_TESTS_BY_TEXT,
        query: {"text": txt, "priceSorting": true}).then((value) {
      searchByText = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }

  GetLabTests? searchSingleTestByText;
  getSearchSingleTestByText({
    String? txt,
  }) {
    emit(GetLabsLoading());
    DioHelper.postData(
        path: ApiUrls.GET_SINGLE_TESTS_BY_TEXT,
        query: {"text": txt, "priceSorting": true}).then((value) {
      searchByText = GetLabTests.fromJson(value.data);
      emit(GetLabsSuccess());
    }).catchError((error) {
      emit(GetLabsError());
    });
  }
}
