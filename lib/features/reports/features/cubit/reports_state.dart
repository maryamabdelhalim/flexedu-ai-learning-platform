abstract class ReportsState {}

class ReportsStateInitial extends ReportsState {}
class ChangeIndexState extends ReportsState {}
class GetBlogsLoading extends ReportsState {}
class GetBlogsSuccess extends ReportsState {}
class GetBlogsError extends ReportsState {}