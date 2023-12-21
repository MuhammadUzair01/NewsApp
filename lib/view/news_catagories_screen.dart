// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsa_app/view_model/news_view_model.dart';

import '../models/categories_news_model.dart';
import 'news_detail_screen.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM,dd, yyyy');
  String categories = 'General';

  // ignore: non_constant_identifier_names
  List<String> CategoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final format = DateFormat('MMMM,dd, yyyy');
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('News')),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CategoriesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    categories = CategoriesList[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: categories == CategoriesList[index]
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                            child: Text(
                          CategoriesList[index].toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fatchCategoriesNewsApi(categories),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
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
                                      placeholder: (context, url) => Container(
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
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
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
