class SubjectsResponse {
  SubjectsResponse({
    this.status,
    this.message,
    this.courseName,
    this.subjects,
  });

  String? status;
  String? message;
  String? courseName;
  List<Subject>? subjects;

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      SubjectsResponse(
        status: json["status"],
        message: json["message"],
        courseName: json["course_name"],
        subjects: List<Subject>.from(
          json["subjects"].map(
            (x) => Subject.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "course_name": courseName,
        "subjects": List<dynamic>.from(
          subjects!.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Subject {
  Subject({
    this.subjId,
    this.subjName,
  });

  int? subjId;
  String? subjName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjId: json["subj_id"],
        subjName: json["subj_name"],
      );

  Map<String, dynamic> toJson() => {
        "subj_id": subjId,
        "subj_name": subjName,
      };
}

class Chapters {
  Chapters({
    this.status,
    this.message,
    this.courseName,
    this.subjectName,
    this.chapterIds,
    this.chapterNames,
  });

  String? status;
  String? message;
  String? courseName;
  String? subjectName;
  List<int>? chapterIds;
  List<String>? chapterNames;

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
        status: json["status"],
        message: json["message"],
        courseName: json["course_name"],
        subjectName: json["subject_name"],
        chapterIds: List<int>.from(json["chapter_ids"].map((x) => x)),
        chapterNames: List<String>.from(json["chapter_names"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "course_name": courseName,
        "subject_name": subjectName,
        "chapter_ids": List<dynamic>.from(chapterIds!.map((x) => x)),
        "chapter_names": List<dynamic>.from(chapterNames!.map((x) => x)),
      };
}
