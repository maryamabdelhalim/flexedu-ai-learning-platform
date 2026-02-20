class ApiUrls {
  static String BASE_URL = 'http://api-stage.flexedu.com/'; // test
  static String URL =
      'http://web-stage.flexedu.com/94343832-8BB9-43B4-9B32-9D2AC5AE8CEE.jpg'; // test

  // Auth Urls

  static String LOGIN = 'Auth/GetToken';
  static String REGISTER = 'Auth/Register';
  static String FORGOTPASSWORD = 'Auth/ForgotPassword';
  static String VERIFYCODE = 'Auth/ResetPassword';

  static String ISCORRECTOTP = 'Auth/IsCorrectOTP';

  // reports Urls

  static String GET_REPORTS = 'Blogs/GetBlogsTable';
  static String GET_BLOGS = 'Blogs/GetBlogs';

  //  Labs

  static String GET_LABS = 'Labs/GetAllLabs';
  static String GET_LABS_TESTS = 'Labs/GetAllLabsTests';

  // Seaerch

  static String GET_LABS_BY_TEXT = 'Labs/GetAllTheLabsThatContainsThisText';
  static String GET_TESTS_BY_TEXT = 'Labs/GetAllTestsThatContainsThisText';
  static String GET_SINGLE_TESTS_BY_TEXT =
      'Labs/GetAllSingleTestsThatContainsThisText';
  static String GET_PACKAGE_TESTS_BY_TEXT =
      'Labs/GetAllPackageTestsThatContainsThisText';

  // Category

  static String GET_CATEGORIES = 'Sections/GetSectionsTable';

  // contact Us

  static String CONTACT_US = 'Home/ContactUs';

// Cities

  static String GET_CITIES = 'Cities/GetCitiesList';
  static String GET_REGIONS = 'Regions/GetRegionsList';
  static String GET_DISTRICTS = 'Districts/GetDistrictsList';
  static String GET_DISTRICTS_BY_CITY = 'Districts/GetDistrictsListByCityId';
  static String GET_CITIES_BY_REGION = 'Cities/GetCitiesListByRegionId';
}
