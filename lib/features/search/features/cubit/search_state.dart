abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeIndexState extends SearchState {}
class GetLabsLoading extends SearchState {}
class GetLabsSuccess extends SearchState {}
class GetLabsError extends SearchState {}
class GetCitiesLoading extends SearchState {}
class GetCitiesSuccess extends SearchState {}
class GetCitiesError extends SearchState {}
class GetCategoryLoading extends SearchState {}
class GetCategorySuccess extends SearchState {}
class GetCategoryError extends SearchState {}
