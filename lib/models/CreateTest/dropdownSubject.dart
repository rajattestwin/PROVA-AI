// ignore_for_file: file_names

class DropdownSubjectCourses {
  String? status;
  String? message;
  List<EngCourses>? engCourses;

  DropdownSubjectCourses(
      {required this.status, required this.message, required this.engCourses});

  DropdownSubjectCourses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['eng_courses'] != null) {
      engCourses = <EngCourses>[];
      json['eng_courses'].forEach(
        (v) {
          engCourses!.add(EngCourses.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['eng_courses'] = engCourses!.map((v) => v.toJson()).toList();
    return data;
  }
}

class EngCourses {
  int? courseId;
  String? courseName;
  List<Subjects>? subjects;

  EngCourses(
      {required this.courseId,
      required this.courseName,
      required this.subjects});

  EngCourses.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Subjects {
  int? subjId;
  String? subjName;
  List<int>? chapterIds;
  List<String>? chapterNames;

  Subjects(
      {required this.subjId,
      required this.subjName,
      required this.chapterIds,
      required this.chapterNames});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjId = json['subj_id'];
    subjName = json['subj_name'];
    chapterIds = json['chapter_ids'].cast<int>();
    chapterNames = json['chapter_names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subj_id'] = subjId;
    data['subj_name'] = subjName;
    data['chapter_ids'] = chapterIds;
    data['chapter_names'] = chapterNames;
    return data;
  }
}
