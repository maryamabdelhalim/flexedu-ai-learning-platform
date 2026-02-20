class GetCategories {
  String? id;
  String? arabicName;
  String? englishName;
  int? medicalTestsCount;
  List<String>? filesIdsAndExtensions;
  bool? isActive;
  bool? mostCommonOption;

  GetCategories(
      {this.id,
      this.arabicName,
      this.englishName,
      this.medicalTestsCount,
      this.filesIdsAndExtensions,
      this.isActive,
      this.mostCommonOption});

  GetCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    medicalTestsCount = json['medicalTestsCount'];
    filesIdsAndExtensions = json['filesIdsAndExtensions'].cast<String>();
    isActive = json['isActive'];
    mostCommonOption = json['mostCommonOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['medicalTestsCount'] = this.medicalTestsCount;
    data['filesIdsAndExtensions'] = this.filesIdsAndExtensions;
    data['isActive'] = this.isActive;
    data['mostCommonOption'] = this.mostCommonOption;
    return data;
  }
}
