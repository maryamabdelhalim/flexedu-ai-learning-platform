class GetLabTests {
  int? totalRecordsCount;
  int? pageNumber;
  int? pageSize;
  List<TestData>? data;

  GetLabTests(
      {this.totalRecordsCount, this.pageNumber, this.pageSize, this.data});

  GetLabTests.fromJson(Map<String, dynamic> json) {
    totalRecordsCount = json['totalRecordsCount'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    if (json['data'] != null) {
      data = <TestData>[];
      json['data'].forEach((v) {
        data!.add(new TestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecordsCount'] = this.totalRecordsCount;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestData {
  List<String>? imagesIdsAndExtensions;
  List<String>? videosIdsAndExtensions;
  String? id;
  String? name;
  dynamic arabicName;
  dynamic englishName;
  String? testName;
  String? branch;
  String? price;
  int? priceDouble;
  dynamic filesIdsAndExtensions;
  dynamic workHoursString;
  String? visitPrecentString;
  bool? supportPackages;
  bool? supportSingleTest;
  bool? supportInsurance;
  String? phoneNumber;
  String? websiteLink;
  String? description;
  bool? isPackage;
  String? medicalTestId;
  int? searchType;

  TestData(
      {this.imagesIdsAndExtensions,
      this.videosIdsAndExtensions,
      this.id,
      this.name,
      this.arabicName,
      this.englishName,
      this.testName,
      this.branch,
      this.price,
      this.priceDouble,
      this.filesIdsAndExtensions,
      this.workHoursString,
      this.visitPrecentString,
      this.supportPackages,
      this.supportSingleTest,
      this.supportInsurance,
      this.phoneNumber,
      this.websiteLink,
      this.description,
      this.isPackage,
      this.medicalTestId,
      this.searchType});

  TestData.fromJson(Map<String, dynamic> json) {
    imagesIdsAndExtensions = json['imagesIdsAndExtensions'].cast<String>();
    videosIdsAndExtensions = json['videosIdsAndExtensions'].cast<String>();
    id = json['id'];
    name = json['name'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    testName = json['testName'];
    branch = json['branch'];
    price = json['price'];
    priceDouble = json['priceDouble'];
    filesIdsAndExtensions = json['filesIdsAndExtensions'];
    workHoursString = json['workHoursString'];
    visitPrecentString = json['visitPrecentString'];
    supportPackages = json['supportPackages'];
    supportSingleTest = json['supportSingleTest'];
    supportInsurance = json['supportInsurance'];
    phoneNumber = json['phoneNumber'];
    websiteLink = json['websiteLink'];
    description = json['description'];
    isPackage = json['isPackage'];
    medicalTestId = json['medicalTestId'];
    searchType = json['searchType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagesIdsAndExtensions'] = this.imagesIdsAndExtensions;
    data['videosIdsAndExtensions'] = this.videosIdsAndExtensions;
    data['id'] = this.id;
    data['name'] = this.name;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['testName'] = this.testName;
    data['branch'] = this.branch;
    data['price'] = this.price;
    data['priceDouble'] = this.priceDouble;
    data['filesIdsAndExtensions'] = this.filesIdsAndExtensions;
    data['workHoursString'] = this.workHoursString;
    data['visitPrecentString'] = this.visitPrecentString;
    data['supportPackages'] = this.supportPackages;
    data['supportSingleTest'] = this.supportSingleTest;
    data['supportInsurance'] = this.supportInsurance;
    data['phoneNumber'] = this.phoneNumber;
    data['websiteLink'] = this.websiteLink;
    data['description'] = this.description;
    data['isPackage'] = this.isPackage;
    data['medicalTestId'] = this.medicalTestId;
    data['searchType'] = this.searchType;
    return data;
  }
}
