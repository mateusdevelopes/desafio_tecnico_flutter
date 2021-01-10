import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String poster;
  DetailsPage({Key key, this.title, this.poster}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Hero(
                tag: 'tag' + widget.title,
                child: Container(
                  height: 600,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new NetworkImage(
                            "https://image.tmdb.org/t/p/w500${widget.poster}"),
                        fit: BoxFit.fill),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
