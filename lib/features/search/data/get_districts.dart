class GetDistrictsList {
  bool? disabled;
  Null? group;
  bool? selected;
  String? text;
  String? value;

  GetDistrictsList(
      {this.disabled, this.group, this.selected, this.text, this.value});

  GetDistrictsList.fromJson(Map<String, dynamic> json) {
    disabled = json['disabled'];
    group = json['group'];
    selected = json['selected'];
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disabled'] = this.disabled;
    data['group'] = this.group;
    data['selected'] = this.selected;
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}
