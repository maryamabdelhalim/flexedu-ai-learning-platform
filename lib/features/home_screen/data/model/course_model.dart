class CourseModel {
  String? id;
  String? title;
  String? description;
  String? price;
  String? level;
  String? progress;
  String? trueAnswers;
  bool? isSubcripe ;

  CourseModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.level,
    this.progress,
    this.trueAnswers,
    this.isSubcripe ,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['level'] = level;
    data['progress'] = progress;
    data['trueAnswers'] = trueAnswers;
    data['isSubcripe'] = isSubcripe;
    return data;
  }

   factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      level: json['level'],
      progress: json['progress'],
      trueAnswers: json['trueAnswers'],
      isSubcripe: json['isSubcripe']?? false,
    );
  }
}
