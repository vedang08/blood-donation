class Donor {
  int id;
  String category;
  String name;
  int contact;
  int age;
  String gender;
  String location;
  String illness;
  bool donated;
  String group;
  int timestamp;

  Donor(
      {this.id,
      this.category,
      this.name,
      this.contact,
      this.age,
      this.gender,
      this.location,
      this.illness,
      this.donated,
      this.group,
      this.timestamp});

  Donor.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? "";
    category = json['category'];
    name = json['name'];
    contact = int.parse(json['contact']);
    age = int.parse(json['age']);
    gender = json['gender'];
    location = json['location'];
    illness = json['illness'];
    donated = json['donated'] == 'Y' ? true : false;
    group = json['group'];
    timestamp = json['timestamp'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id ?? null;
    data['category'] = this.category;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['age'] = this.age;
    data['location'] = this.location;
    data['illness'] = this.illness;
    data['donated'] = this.donated;
    data['group'] = this.group;
    data['gender'] = this.gender;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
