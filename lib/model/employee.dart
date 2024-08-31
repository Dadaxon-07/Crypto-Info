class Employee {
  String? status;
  List<Data>? data;
  String? message;

  Employee({this.status, this.data, this.message});

  Employee.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message
      };
}

class Data {
  int? id;
  String? employee_name;
  String? employee_salary;
  int? employee_age;
  String? profile_image;

  Data(
      {this.id,
      this.employee_name,
      this.employee_salary,
      this.employee_age,
      this.profile_image});

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        employee_name = json['employee_name'],
        employee_salary = json['employee_salary'],
        employee_age = json['employee_age'],
        profile_image = json['profile_image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'employee_name': employee_name,
        'employee_salary': employee_salary,
        'employee_age': employee_age,
        'profile_image': profile_image
      };
}
