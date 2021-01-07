import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_response_model.dart';
import 'package:desafio_tecnico_flutter/shared/services/movie_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size preferredSize = Size.fromHeight(kToolbarHeight * 0.8);
  MovieResponse responseList;

  @override
  void initState() {
    super.initState();
    // getMvByG();
  }

  Future<List<Movie>> getMvByG() async {
    try {
      var response = await movieService.getMoviesByGenre("12");
      print(response.movies.length);
      return response.movies;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Filmes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Container(
                  // color: Colors.green,
                  ),
            ),
            FutureBuilder<List<Movie>>(
                future: getMvByG(),
                builder: (context, snapshot) {
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWrapper(
                              onTap: () {},
                              radius: 10,
                              child: Container(
                                height: 600,
                                width: width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: new NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${snapshot.data[index].poster}"),
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
                                        colors: [
                                          Colors.transparent,
                                          Colors.black
                                        ],
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
                                              snapshot.data[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            AutoSizeText(
                                              snapshot.data[index].popularity
                                                  .toString(),
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
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class InkWrapper extends StatelessWidget {
  final Color splashColor;
  final double radius;
  final Widget child;
  final VoidCallback onTap;

  InkWrapper({
    this.splashColor,
    this.radius = 0,
    @required this.child,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              splashColor: splashColor,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
