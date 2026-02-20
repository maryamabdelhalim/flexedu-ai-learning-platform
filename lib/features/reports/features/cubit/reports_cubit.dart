import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/reports/data/model/get_reports.dart';
import 'package:flexedu/features/reports/features/cubit/reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsStateInitial());

  static ReportsCubit get(context) => BlocProvider.of(context);
  List<BlogsModel> blogs = [];
  BlogsModel? blogsModel;

  getReports() async {
    try {
      emit(GetBlogsLoading());
      var response = await DioHelper.getData(endpoint: ApiUrls.GET_REPORTS);
      if (response == null) {
        return null;
      }
      // blogsModel = BlogsModel.fromJson(response!.data);
      final List<dynamic> data = response.data;

      blogs = data.map((json) => BlogsModel.fromJson(json)).toList();

      emit(GetBlogsSuccess());
    } catch (er) {
      emit(GetBlogsError());
    }
  }
}
