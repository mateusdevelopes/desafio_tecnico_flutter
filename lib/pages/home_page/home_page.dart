import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/models/genre_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_response_model.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/details_page.dart';
import 'package:desafio_tecnico_flutter/pages/home_page/widgets/movie_item.dart';
import 'package:desafio_tecnico_flutter/shared/services/movie_service.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/widgets/ink_wrapper.dart';
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
  TextEditingController searchController = new TextEditingController();
  String searchString = '';
  int _selectedIndex = 0;
  int movieId = 12;

  Future<List<Genre>> getGenres() async {
    try {
      var response = await movieService.getGenres();
      return response.genres;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Movie>> getMoviesByGenres(int gebreId) async {
    try {
      var response = await movieService.getMoviesByGenre("$gebreId");
      return response.movies;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
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
                  onChanged: (value) {
                    setState(() {
                      searchString = value;
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Pesquisar filmes",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: getGenres(),
                builder: (context, snapshot) {
                  if (ConnectionState.active != null && !snapshot.hasData) {
                    return Center(
                        child: Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator()));
                  }

                  if (ConnectionState.done != null && snapshot.hasError) {
                    return Center(child: Text(snapshot.error));
                  }

                  return SizedBox(
                      height: 90,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: FlatButton(
                                    height: 20,
                                    color: _selectedIndex == index
                                        ? DesignColors.COR_GENRE_TOGGLE
                                        : Colors.white,
                                    // disabledColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        side: BorderSide(
                                            color: _selectedIndex == index
                                                ? DesignColors.COR_GENRE_TOGGLE
                                                : Colors.grey)),
                                    child: AutoSizeText(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : DesignColors.COR_GENRE_TOGGLE,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedIndex = index;
                                        movieId = snapshot.data[index].id;
                                      });
                                      print(snapshot.data[index].id);
                                    },
                                  ),
                                ),
                              ),
                            );
                          }));
                }),
            mainList(id: movieId, width: width)
          ],
        ),
      ),
    );
  }

  Widget mainList({int id, double width}) {
    return FutureBuilder<List<Movie>>(
        future: getMoviesByGenres(id),
        builder: (context, snapshot) {
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(
              child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator()),
            );
          }

          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

          return Expanded(
            flex: 6,
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return snapshot.data[index].title.contains(searchString)
                      ? MovieItem(
                          id: snapshot.data[index].id,
                          title: snapshot.data[index].title,
                          poster: snapshot.data[index].poster,
                          detail: snapshot.data[index].originalTitle,
                          width: width,
                        )
                      : Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                }),
          );
        });
  }
}
