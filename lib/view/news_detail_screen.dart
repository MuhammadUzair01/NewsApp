import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsimage,
      newsdate,
      auther,
      newstitle,
      description,
      content,
      source;

  const NewsDetailScreen(
      {super.key,
      required this.auther,
      required this.content,
      required this.description,
      required this.newsdate,
      required this.newsimage,
      required this.newstitle,
      required this.source});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMM,dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    DateTime datetime = DateTime.parse(widget.newsdate);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(child: Text('News'))),
      body: Stack(
        children: [
          SizedBox(
            height: height * .28,
            width: width * 1,
            child: CachedNetworkImage(
                imageUrl: widget.newsimage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    )),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .3),
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: ListView(
              children: [
                Text(
                  widget.newstitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: height * .03),
                    Text(
                      format.format(datetime),
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: height * .03),
                Text(
                  widget.description,
                  maxLines: 5,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
