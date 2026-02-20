class BlogsModel {
  String? id;
  String? arabicTitle;
  String? englishTitle;
  String? arabicContent;
  String? englishContent;
  List<String>? filesIdsAndExtensions;
  int? helpfulsCount;
  bool? iVoted;
  String? createDateTime;

  BlogsModel(
      {this.id,
      this.arabicTitle,
      this.englishTitle,
      this.arabicContent,
      this.englishContent,
      this.filesIdsAndExtensions,
      this.helpfulsCount,
      this.iVoted,
      this.createDateTime});

  BlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicTitle = json['arabicTitle'];
    englishTitle = json['englishTitle'];
    arabicContent = json['arabicContent'];
    englishContent = json['englishContent'];
    filesIdsAndExtensions = json['filesIdsAndExtensions'].cast<String>();
    helpfulsCount = json['helpfulsCount'];
    iVoted = json['iVoted'];
    createDateTime = json['createDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabicTitle'] = this.arabicTitle;
    data['englishTitle'] = this.englishTitle;
    data['arabicContent'] = this.arabicContent;
    data['englishContent'] = this.englishContent;
    data['filesIdsAndExtensions'] = this.filesIdsAndExtensions;
    data['helpfulsCount'] = this.helpfulsCount;
    data['iVoted'] = this.iVoted;
    data['createDateTime'] = this.createDateTime;
    return data;
  }
}
