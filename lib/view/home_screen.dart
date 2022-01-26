import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:test_arkademi/model/course_model.dart';
import 'package:test_arkademi/provider/home_provider.dart';

import 'widget/home_curiculum.dart';
import 'widget/home_video.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _provider = Provider.of<HomeProvider>(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: FutureBuilder<CourseModel>(
        future: _provider.fnFetchCourse(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _provider.saveCourse(snapshot.data);
            return Consumer<HomeProvider>(
              builder: (_, provs, __) => Scaffold(
                backgroundColor: Colors.white,
                appBar: provs.isLoading
                    ? null
                    : AppBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        toolbarHeight: kToolbarHeight,
                        leading: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black87,
                        ),
                        title: Row(
                          children: [
                            SizedBox(
                              width: _size.width / 1.6,
                              child: Text(
                                provs.course.courseName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CircularPercentIndicator(
                              radius: 20.0,
                              lineWidth: 3.0,
                              percent:
                                  double.parse(provs.course.progress!) / 100,
                              center: Text(
                                "${provs.course.progress!} %",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                ),
                              ),
                              progressColor: Colors.green,
                            ),
                          )
                        ],
                      ),
                body: provs.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : NestedScrollView(
                        headerSliverBuilder: (context, val) => [
                          provs.selectedVideo == null ||
                                  provs.selectedVideo == ""
                              ? const SliverAppBar(
                                  expandedHeight: 0,
                                  toolbarHeight: 0,
                                )
                              : SliverAppBar(
                                  expandedHeight: _size.height / 3.5,
                                  toolbarHeight: 0,
                                  floating: false,
                                  leading: const SizedBox(),
                                  flexibleSpace: HomeVideo(provider: _provider),
                                ),
                        ],
                        body: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                isScrollable: false,
                                physics: const NeverScrollableScrollPhysics(),
                                onTap: (i) {},
                                indicatorColor: Colors.blue[900],
                                indicatorWeight: 3,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.black,
                                labelStyle: GoogleFonts.aBeeZee(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                tabs: const [
                                  Tab(text: "Kurikulum"),
                                  Tab(text: "Ikhtisar"),
                                  Tab(text: "Lampiran"),
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: HomeCuriculum(provider: _provider),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
