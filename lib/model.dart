class ResponseModel {
  final List<Response> response;
  final List<String> errors;

  ResponseModel({required this.response, required this.errors});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      response: (json['response'] as List).map((i) => Response.fromJson(i)).toList(),
      errors: List<String>.from(json['errors']),
    );
  }
}

class Response {
  final String id;
  final List<Course> course;
  final String name;
  final bool optional;
  final List<Student> student;
  final int start_date;
  final List<Attachments> attachments;
  final int due_date;

  Response({required this.id, required this.course, required this.name, required this.optional, required this.student, required this.start_date, required this.attachments, required this.due_date});
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['_id'],
      course: (json['course'] as List).map((i) => Course.fromJson(i)).toList(),
      name: json['name'],
      optional: json['optional'],
      student: (json['student'] as List).map((i) => Student.fromJson(i)).toList(),
      start_date: json['start_date'],
      attachments: (json['attachments'] as List).map((i) => Attachments.fromJson(i)).toList(),
      due_date: json['due_date'],
    );
  }
}
class Course{
  final String id;
  final String name;
  final String teacher;

  Course({required this.id, required this.name, required this.teacher});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      name: json['name'],
      teacher: json['teacher'],
    );
  }
}

class Student{
  final String id;
  final String student;
  final bool in_progress;
  final bool done;
  final String name_show;

  Student({required this.id, required this.student, required this.in_progress, required this.done, required this.name_show});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      student: json['name'],
      in_progress: json['in_progress'],
      done: json['done'],
      name_show: json['name_show'],
    );
  }
}

class Attachments{
  final String name;
  final String path;
  final int size;
  final String id;

  Attachments({required this.name, required this.path, required this.size, required this.id});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      name: json['name'],
      path: json['path'],
      size: json['size'],
      id: json['_id'],

    );
  }
}