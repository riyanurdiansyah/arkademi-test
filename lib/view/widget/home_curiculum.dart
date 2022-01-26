import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_arkademi/provider/home_provider.dart';

class HomeCuriculum extends StatelessWidget {
  const HomeCuriculum({
    Key? key,
    required HomeProvider provider,
  })  : _provider = provider,
        super(key: key);

  final HomeProvider _provider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(_provider.course.curriculum!.length, (i) {
        final _data = _provider.course.curriculum![i];
        if (_data.type! != "section") {
          return Column(
            children: [
              ListTile(
                selectedColor: Colors.red,
                selectedTileColor: Colors.red,
                tileColor: _provider.selectedIndex == i
                    ? Colors.blue.shade100
                    : Colors.white,
                onTap: _provider.selectedIndex != i
                    ? () {
                        _provider.fnSelectedCuriculum(
                            i, _data.onlineVideoLink ?? "");
                      }
                    : null,
                leading: Container(
                  width: 20,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _data.onlineVideoLink!.isEmpty ||
                              _data.onlineVideoLink!.isEmpty
                          ? Icons.document_scanner_rounded
                          : Icons.play_arrow_rounded,
                      size: 15,
                    ),
                  ),
                ),
                title: Text(
                  _data.title!.contains("&#8211;")
                      ? _data.title!.split("&#8211;")[1]
                      : _data.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                trailing: _data.onlineVideoLink!.isEmpty ||
                        _data.onlineVideoLink!.isEmpty
                    ? const SizedBox()
                    : InkWell(
                        onTap: _provider.progressDownload[i].toInt() == 1
                            ? null
                            : () {
                                _provider.fnSelectedCuriculum(
                                    i, _data.onlineVideoLink ?? "");

                                _provider.fnDownloadVideo(
                                    _data.onlineVideoLink!, _data.title, i);
                              },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: _provider.progressDownload[i] > 0
                                    ? Colors.indigo[200]
                                    : Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                )),
                            child: Stack(
                              children: <Widget>[
                                AnimatedContainer(
                                  color:
                                      _provider.progressDownload[i].toInt() == 1
                                          ? Colors.white
                                          : Colors.indigo[400],
                                  width: _provider.progressDownload[i] * 100,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.fastOutSlowIn,
                                ),
                                Center(
                                  child: Text(
                                    _provider.progressDownload[i].toInt() == 1
                                        ? "Tersimpan"
                                        : _provider.progressDownload[i] > 0
                                            ? "Progress.. ${(_provider.progressDownload[i] * 100).toInt()} %"
                                            : "Tonton Offline",
                                    style: GoogleFonts.poppins(
                                      color: _provider.progressDownload[i]
                                                  .toInt() ==
                                              1
                                          ? Colors.black87
                                          : Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              _data.type == "section" && i == 0
                  ? const SizedBox()
                  : Container(
                      height: 2,
                      color: Colors.grey.shade200,
                    )
            ],
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: _data.title!.toLowerCase() != "penutup"
                        ? "BAB ${_provider.listBab!.indexWhere((e) => e.contains(_data.title!)) + 1}: "
                        : "Penutup",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      if (_data.title!.toLowerCase() != "penutup")
                        TextSpan(
                          text: _data.title,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ],
                  ),
                ),
                Text("${_data.duration! ~/ 60} Menit")
              ],
            ),
          );
        }
      }),
    );
  }
}
