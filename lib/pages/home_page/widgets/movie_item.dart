import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/details_page.dart';
import 'package:desafio_tecnico_flutter/pages/home_page/home_page.dart';
import 'package:desafio_tecnico_flutter/widgets/ink_wrapper.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  MovieItem({Key key, this.id, this.title, this.poster, this.width, this.detail}) : super(key: key);
  final int id;
  final String title;
  final String poster;
  final double width;
  final String detail;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWrapper(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                id: id,
                title: title,
                poster: poster,
              ),
            ),
          );
        },
        radius: 10,
        child: Hero(
          tag: 'tag' + title,
          child: Container(
            height: 600,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: new NetworkImage(
                      "https://image.tmdb.org/t/p/w500${poster}"),
                  fit: BoxFit.fill),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: width,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: FractionalOffset(0, 0.7),
                    end: FractionalOffset(0, 1),
                    stops: [0.0, 0.8],
                    tileMode: TileMode.clamp),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 20,
                      children: [
                        AutoSizeText(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        AutoSizeText(
                          detail.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
