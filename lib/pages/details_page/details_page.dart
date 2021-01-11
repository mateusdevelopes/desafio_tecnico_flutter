import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/models/cast_model.dart';
import 'package:desafio_tecnico_flutter/models/crew_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/shared/services/movie_service.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:desafio_tecnico_flutter/widgets/ink_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String poster;
  DetailsPage({Key key, this.title, this.poster, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int directorListLenght = 3;

  @override
  void initState() {
    // resq();
    super.initState();
  }

  Future<Movie> getMovieDetailsByID(int id) async {
    try {
      var response = await movieService.getMovieDetails(id);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, 0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          FutureBuilder(
              future: getMovieDetailsByID(widget.id),
              builder: (context, snapshot) {
                var runtimeFormated =
                    snapshot.data.runtime.toString().split("");
                print(runtimeFormated);
                return Container(
                  color: DesignColors.COLOR_WHITE_DARK,
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: SizedBox(
                          height: height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "${snapshot.data.voteAverage} ",
                                    style: TextStyle(
                                        fontFamily: DesignFont.montserrat,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24),
                                  ),
                                  AutoSizeText(
                                    "/ 10",
                                    style: TextStyle(
                                        fontFamily: DesignFont.montserrat,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 15),
                                child: Container(
                                  child: AutoSizeText(
                                    snapshot.data.title,
                                    style: TextStyle(
                                        fontFamily: DesignFont.montserrat,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "Titulo original: ",
                                      style: TextStyle(
                                          fontFamily: DesignFont.montserrat,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13),
                                    ),
                                    AutoSizeText(
                                      snapshot.data.originalTitle,
                                      style: TextStyle(
                                          fontFamily: DesignFont.montserrat,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width,
                                padding: EdgeInsets.all(10),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  children: [
                                    Container(
                                      color: DesignColors.COLOR_LIGHT_BLUE,
                                      padding: EdgeInsets.all(12),
                                      child: Wrap(
                                        children: [
                                          AutoSizeText(
                                            "Ano: ",
                                            style: TextStyle(
                                                fontFamily:
                                                    DesignFont.montserrat,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          AutoSizeText(
                                            snapshot.data.releaseDate
                                                .substring(0, 4),
                                            style: TextStyle(
                                                fontFamily:
                                                    DesignFont.montserrat,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: DesignColors.COLOR_LIGHT_BLUE,
                                      padding: EdgeInsets.all(12),
                                      child: Wrap(
                                        children: [
                                          AutoSizeText(
                                            "Duração: ",
                                            style: TextStyle(
                                                fontFamily:
                                                    DesignFont.montserrat,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                          AutoSizeText(
                                            "${runtimeFormated[0]}h ${runtimeFormated[1]}${runtimeFormated[2]} min",
                                            style: TextStyle(
                                                fontFamily:
                                                    DesignFont.montserrat,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                children: [],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 10),
                                    child: AutoSizeText(
                                      "Descrição",
                                      style: TextStyle(
                                          fontFamily: DesignFont.montserrat,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ),
                                  AutoSizeText(
                                    snapshot.data.overview,
                                    style: TextStyle(
                                        fontFamily: DesignFont.montserrat,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  color: DesignColors.COLOR_LIGHT_BLUE,
                                  child: Row(
                                    children: [
                                      AutoSizeText(
                                        "ORÇAMENTO: ",
                                        style: TextStyle(
                                            fontFamily: DesignFont.montserrat,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      AutoSizeText(
                                        "\$ ${snapshot.data.budget.toString()}",
                                        style: TextStyle(
                                            fontFamily: DesignFont.montserrat,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: width,
                                  padding: EdgeInsets.all(12),
                                  color: DesignColors.COLOR_LIGHT_BLUE,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: AutoSizeText(
                                          "PRODUTORAS: ",
                                          style: TextStyle(
                                              fontFamily: DesignFont.montserrat,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: width - 200,
                                        child: SizedBox(
                                          height: 20,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              itemCount: snapshot.data
                                                  .productionCompanies.length,
                                              itemBuilder: (context, index) {
                                                return AutoSizeText(
                                                  "${snapshot.data.productionCompanies[index].name} -",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          DesignFont.montserrat,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText(
                                        "Diretor:",
                                        style: TextStyle(
                                            fontFamily: DesignFont.montserrat,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      child: SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: directorListLenght,
                                            itemBuilder: (context, index) {
                                              List<Crew> filteredList = snapshot
                                                  .data.credits.crew
                                                  .where((element) =>
                                                      element.job == 'Director')
                                                  .toList();
                                              directorListLenght =
                                                  filteredList.length;
                                              return AutoSizeText(
                                                "${filteredList[index].name}, ",
                                                style: TextStyle(
                                                    fontFamily:
                                                        DesignFont.montserrat,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: AutoSizeText(
                                        "Elenco:",
                                        style: TextStyle(
                                            fontFamily: DesignFont.montserrat,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      child: SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot
                                                .data.credits.cast.lenght,
                                            itemBuilder: (context, index) {
                                              List<Cast> filteredList =
                                                  snapshot.data.credits.cast;
                                              return AutoSizeText(
                                                "${snapshot.data.credits.cast[index].name}, ",
                                                style: TextStyle(
                                                    fontFamily:
                                                        DesignFont.montserrat,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWrapper(
                      radius: 60,
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                                AutoSizeText("Voltar")
                              ],
                            )),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 80),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: ImagePoster(
                  title: widget.title,
                  width: width,
                  poster: widget.poster,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

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
