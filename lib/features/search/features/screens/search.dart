import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/home_screen/data/model/get_categories.dart';
import 'package:flexedu/features/labs/data/model/get_labs_model.dart';
import 'package:flexedu/features/labs/features/componant/get_labs.dart';
import 'package:flexedu/features/labs/features/componant/labs_get_more_details.dart';
import 'package:flexedu/features/labs/features/cubit/labs_state.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/search/data/model/cities_model.dart';
import 'package:flexedu/features/search/features/cubit/search_cubit.dart';
import 'package:flexedu/features/search/features/cubit/search_state.dart';
import 'package:flexedu/features/search/features/screens/get_search_data.dart';
import 'package:flexedu/features/search/features/screens/get_search_data_by_text.dart';
import 'package:flexedu/features/search/features/screens/get_search_data_by_text_labs.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_more_details.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortBy {
  final int id;
  final String name;

  SortBy({required this.id, required this.name});
}

class SearchType {
  final int id;
  final String name;

  SearchType({required this.id, required this.name});
}

class SearchFiltersScreen extends StatefulWidget {
  @override
  _SearchFiltersScreenState createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  // المتغيرات المختارة
  CitiesModel? selectedCity;
  CitiesModel? selectedDistrict;
  CitiesModel? region;
  GetCategories? categories;
  TestData? labs;
  TestData? labsTest;
  SortBy? sortBy;
  SearchType? searchType;
  var searchController = TextEditingController();
  // القوائم
  final List<SortBy> sorts = [
    SortBy(id: 1, name: 'السعر من الاقل الى الاعلى'),
    SortBy(id: 2, name: 'السعر من الاعلى الى الاقل'),
  ];
  final List<SearchType> types = [
    SearchType(id: 1, name: 'المعامل'),
    SearchType(id: 2, name: 'جميع التحاليل'),
    SearchType(id: 3, name: 'تحاليل فرديه'),
    SearchType(id: 4, name: 'باقات'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            bottomSheet: BottomSheetScreen(),
            backgroundColor: Theme.of(context).primaryColorLight,
            body: Padding(
              padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
              child: cubit.cities == null &&
                      cubit.districts == null &&
                      cubit.regions == null &&
                      cubit.categories == null &&
                      cubit.labsTest == null &&
                      cubit.labs == null
                  ? Center(child: LoadingWidget())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    pop(context);
                                  },
                                  child: Icon(CupertinoIcons.clear_circled,
                                      color: AppColors.mainColor)),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          buildDropdown<SearchType>(
                            title: "Search Type".tr(),
                            hint: "All Tests".tr(),
                            value: searchType,
                            list: types,
                            onChanged: (val) {
                              setState(() => searchType = val);
                            },
                            getLabel: (searchType) =>
                                searchType.name.toString(),
                          ),
                          if (searchType?.id != 1)
                            buildDropdown<GetCategories>(
                              title: "Categories".tr(),
                              hint: "All Categories".tr(),
                              value: categories,
                              list: cubit.categories ?? [],
                              onChanged: (val) {
                                setState(() => categories = val);
                              },
                              getLabel: (category) =>
                                  category.arabicName.toString(),
                            ),
                          if (searchType?.id != 1)
                            buildDropdown<TestData>(
                              title: "Medical examinations".tr(),
                              hint: "All Labs".tr(),
                              value: labsTest,
                              list: cubit.labsTest?.data ?? [],
                              onChanged: (val) {
                                setState(() => labsTest = val);
                              },
                              getLabel: (labsTest) => labsTest.name.toString(),
                            ),
                          if (searchType?.id == 1)
                            buildDropdown<TestData>(
                              title: "Medical examinations".tr(),
                              hint: "All Labs".tr(),
                              value: labs,
                              list: cubit.labs?.data ?? [],
                              onChanged: (val) {
                                setState(() => labs = val);
                              },
                              getLabel: (labs) => labs.name.toString(),
                            ),
                          buildDropdown<CitiesModel>(
                            title: "Select the region".tr(),
                            hint: "All areas".tr(),
                            value: region,
                            list: cubit.regions ?? [],
                            onChanged: (val) {
                              setState(() {
                                region = null;
                                region = val;
                                selectedCity = null;
                                selectedDistrict = null;
                                cubit.getCityByRegions(val!.value
                                    .toString()); // ← تأكد أن هذه الدالة موجودة في Cubit
                              });
                            },
                            getLabel: (region) => region.text.toString(),
                          ),
                          buildDropdown<CitiesModel>(
                            title: "Select the City".tr(),
                            hint: "All Cities".tr(),
                            value: selectedCity,
                            list: cubit.cityByRegion ?? [],
                            onChanged: (val) {
                              setState(() {
                                selectedCity = val;
                                // selectedCity = null;
                                selectedDistrict = null;
                                cubit.getDistrictsByCity(val!.value.toString());

                                /// ← تأكد أن هذه الدالة موجودة في Cubit
                              });
                            },
                            getLabel: (city) => city.text.toString(),
                          ),
                          buildDropdown<CitiesModel>(
                            title: "Select the district".tr(),
                            hint: "All districts".tr(),
                            value: selectedDistrict,
                            list: cubit.districtsByCity ?? [],
                            onChanged: (val) {
                              setState(() {
                                selectedDistrict = val;
                                // selectedCity = null;
                                // selectedDistrict = null;
                              });
                            },
                            getLabel: (district) => district.text.toString(),
                          ),
                          buildDropdown<SortBy>(
                            title: "Sort by".tr(),
                            hint: "Sort by".tr(),
                            value: sortBy,
                            list: sorts,
                            onChanged: (val) {
                              setState(() => sortBy = val);
                            },
                            getLabel: (sort) => sort.name,
                          ),
                          SizedBox(height: 10.h),
                          defaultText(
                              txt: 'Search by test name'.tr(),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by test name'.tr(),
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Cairo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          DefaultButton(
                              txt: 'Search'.tr(),
                              onPress: () {
                                // cubit.getSearchLabTests(
                                //   cityId: selectedCity?.value.toString(),
                                //   regionId: region?.value.toString(),
                                //   districtId:
                                //       selectedDistrict?.value.toString(),
                                //   sectionId: categories?.id.toString(),
                                //   labIdOrMedicalTestId: labsTest?.id.toString(),
                                //   priceSortingAsc:
                                //       sortBy?.id == 1 ? true : false,
                                // );

                                if (searchController.text.isNotEmpty) {
                                  if (searchType?.id == 1) {
                                    nextPage(
                                        context,
                                        GetSearchDataByTextLabs(
                                          type: searchType?.id ?? 1,
                                          txt: searchController.text,
                                        ));
                                  } else {
                                    nextPage(
                                        context,
                                        GetSearchDataByText(
                                          type: searchType?.id ?? 1,
                                          txt: searchController.text,
                                        ));
                                  }
                                } else {
                                  nextPage(
                                      context,
                                      GetSearchData(
                                        searchType: searchType?.id ?? 1,
                                        cityId: selectedCity?.value.toString(),
                                        regionId: region?.value.toString(),
                                        districtId:
                                            selectedDistrict?.value.toString(),
                                        sectionId: categories?.id.toString(),
                                        labIdOrMedicalTestId:
                                            labsTest?.id.toString(),
                                        priceSortingAsc:
                                            sortBy?.id == 1 ? true : false,
                                      ));
                                }
                              }),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  Widget buildDropdown<T>({
    required String title,
    required String hint,
    required T? value,
    required List<T> list,
    required ValueChanged<T?> onChanged,
    required String Function(T) getLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(txt: title, fontSize: 14.sp, fontWeight: FontWeight.w600),
          SizedBox(height: 8.h),
          DropdownButtonFormField<T>(
            value: value,
            isExpanded: true,
            style: TextStyle(color: AppColors.blacColor, fontFamily: 'Cairo'),
            dropdownColor: Theme.of(context).primaryColorLight,
            focusColor: AppColors.mainColor,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyle(color: AppColors.blacColor, fontFamily: 'Cairo'),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            items: list.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: defaultText(txt: getLabel(item)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
