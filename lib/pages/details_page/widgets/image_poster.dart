import 'package:flutter/material.dart';

class ImagePoster extends StatelessWidget {
  const ImagePoster({
    Key key,
    @required this.title,
    @required this.width,
    @required this.poster,
  }) : super(key: key);

  final String title;
  final double width;
  final String poster;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'tag' + title,
      child: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: new NetworkImage("https://image.tmdb.org/t/p/w500$poster"),
              fit: BoxFit.fill),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}