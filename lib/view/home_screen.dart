import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsa_app/models/categories_news_model.dart';
import 'package:newsa_app/models/news_channel_headlines_model.dart';
import 'package:newsa_app/view/news_catagories_Screen.dart';
import 'package:newsa_app/view/news_detail_screen.dart';
import 'package:newsa_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, aljazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM,dd, yyyy');
  String name = 'bbc-news';
  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewsCategories()));
            },
            icon:
                Image.asset('images/category_icon.png', height: 30, width: 30),
          ),
          title: Center(
            child: Text('News',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          actions: [
            PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterList.aljazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text('BBC NEWS'),
                ),
                const PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text('ARY NEWS'),
                ),
                const PopupMenuItem<FilterList>(
                  value: FilterList.aljazeera,
                  child: Text('ALJAZEERA NEWS'),
                ),
                const PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text('CNN NEWS'),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: height * .50,
              width: width,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FutureBuilder<NewsChannelsHeadlinesModel>(
                    future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(size: 50, color: Colors.blue),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                        auther: snapshot.data!.articles![index].author
                                            .toString(),
                                        content: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        newsdate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsimage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newstitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        source: snapshot.data!.articles![index].source!.name.toString()),
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.5,
                                      width: width * .9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: height * .02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            child: spinkit2,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: const EdgeInsets.all(15),
                                          height: height * .22,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: width * 0.7,
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: width * 0.7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                        format.format(dateTime),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fatchCategoriesNewsApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.blue),
                    );
                  } else {
                    return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                        auther: snapshot.data!.articles![index].author
                                            .toString(),
                                        content: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        newsdate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsimage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newstitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        source: snapshot.data!.articles![index].source!.name.toString()),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 15, left: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .2,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: spinkit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, right: 13),
                                      child: Container(
                                        height: height * .18,
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ));
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
