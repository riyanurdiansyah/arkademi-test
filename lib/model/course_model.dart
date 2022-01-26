class CourseModel {
  CourseModel({
    this.courseName,
    this.progress,
    this.curriculum,
  });

  String? courseName;
  String? progress;
  List<CurriculumModel>? curriculum;

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    progress = json['progress'];
    if (json['curriculum'] != null) {
      curriculum = <CurriculumModel>[];
      for (var data in json['curriculum']) {
        curriculum!.add(CurriculumModel.fromJson(data));
      }
    }
  }
}

class CurriculumModel {
  CurriculumModel({
    this.key,
    this.id,
    this.type,
    this.title,
    this.duration,
    this.content,
    this.meta,
    this.status,
    this.onlineVideoLink,
    this.offlineVideoLink,
  });

  int? key;
  dynamic id;
  String? type;
  String? title;
  int? duration;
  String? content;
  List<dynamic>? meta;
  int? status;
  String? onlineVideoLink;
  String? offlineVideoLink;

  CurriculumModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    type = json['type'];
    title = json['title'];
    duration = json['duration'];
    content = json['content'];
    meta = [];
    status = (json["status"] == null) ? 0 : json["status"];
    onlineVideoLink =
        (json["online_video_link"] == null) ? "" : json["online_video_link"];
    offlineVideoLink =
        (json["offline_video_link"] == null) ? "" : json["offline_video_link"];
  }
}
