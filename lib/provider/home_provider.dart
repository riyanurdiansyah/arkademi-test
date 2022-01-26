import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_arkademi/model/course_model.dart';
import 'package:test_arkademi/service/home_service.dart';
import 'package:video_player/video_player.dart';

class HomeProvider with ChangeNotifier {
  final _service = HomeService();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  CourseModel? _course;
  CourseModel get course => _course!;
  String? _selectedVideo;
  String? get selectedVideo => _selectedVideo;
  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;
  final List<String>? _listBab = [];
  List<String>? get listBab => _listBab;
  late VideoPlayerController _videoController;
  VideoPlayerController get videoController => _videoController;

  final _dio = Dio();

  final List<double> _progressDownload = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<double> get progressDownload => _progressDownload;
  HomeProvider() {
    Future.delayed(const Duration(seconds: 2), () async {
      _videoController = VideoPlayerController.network(
          "https://storage.googleapis.com/samplevid-bucket/offline_arsenal_westham.mp4");
      _isLoading = false;
      notifyListeners();
    });
  }
  Future<CourseModel> fnFetchCourse() async {
    return await _service.fetchCourse();
  }

  Future<bool> fnDownloadVideo(String url, name, int index) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      await _dio.download(url, "${dir.path}/$name.mp4",
          onReceiveProgress: (receiveByte, totalBytes) {
        _progressDownload[index] = receiveByte / totalBytes;
        notifyListeners();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  void saveCourse(CourseModel? data) {
    _listBab!.clear();
    _course = data;
    for (var bab in data!.curriculum!.where((e) => e.type == "section")) {
      _listBab!.add(bab.title!);
    }
  }

  void fnSelectedCuriculum(int i, String olVideo) {
    _selectedIndex = i;
    _selectedVideo = olVideo;
    if (olVideo != "") {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      }
      _videoController = VideoPlayerController.network(olVideo)
        ..initialize().then((value) {
          notifyListeners();
        });
    } else {
      _videoController.dispose();
    }
    notifyListeners();
  }

  void startPauseVideo() {
    _videoController.value.isPlaying
        ? _videoController.pause()
        : _videoController.play();
    notifyListeners();
  }
}
