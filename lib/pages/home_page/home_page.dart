import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/models/genre_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_response_model.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/details_page.dart';
import 'package:desafio_tecnico_flutter/shared/database/db_provider.dart';
import 'package:desafio_tecnico_flutter/shared/services/movie_service.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size preferredSize = Size.fromHeight(kToolbarHeight * 0.8);
  MovieResponseModel responseList;

  int _selectedIndex = 0;
  List<String> list = [
    "Ação",
    "Fantasia",
    "Comedia",
    "Aventura",
    "Animação",
    "Faroeste"
  ];

  @override
  void initState() {
    super.initState();
    getGenres();
  }

  Future<List<Genre>> getGenres() async {
    try {
      var response = await movieService.getGenres();
      print(response.genres);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Movie>> getMoviesByGenres() async {
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
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(50)),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "email@teste.com",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            color: _selectedIndex == index
                                ? DesignColors.COR_GENRE_TOGGLE
                                : Colors.white,
                            // disabledColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: _selectedIndex == index
                                        ? DesignColors.COR_GENRE_TOGGLE
                                        : Colors.grey)),
                            child: AutoSizeText(
                              list[index],
                              style: TextStyle(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : DesignColors.COR_GENRE_TOGGLE,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          ),
                        ),
                      );
                    })),
            FutureBuilder<List<Movie>>(
                future: getMoviesByGenres(),
                builder: (context, snapshot) {
                  return Expanded(
                    flex: 6,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWrapper(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                      title: snapshot.data[index].title,
                                      poster: snapshot.data[index].poster,
                                    ),
                                  ),
                                );
                              },
                              radius: 10,
                              child: Hero(
                                tag: 'tag' + snapshot.data[index].title,
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
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              AutoSizeText(
                                                snapshot.data[index].popularity
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w900),
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
