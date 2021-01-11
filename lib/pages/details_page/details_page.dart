import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/models/crew_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/back_button_details.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/budget_section.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/description_section.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/image_poster.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/movie_details_flag.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/movie_title.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/original_movie_title.dart';
import 'package:desafio_tecnico_flutter/pages/details_page/widgets/vote_average_scale.dart';
import 'package:desafio_tecnico_flutter/shared/services/movie_service.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String poster;
  DetailsPage({Key key, this.title, this.poster, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int directorListLenght = 1;

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
      backgroundColor: Colors.white,
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
                if (ConnectionState.active != null && !snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (ConnectionState.done != null && snapshot.hasError) {
                  return Center(child: Text(snapshot.error));
                }

                List<Crew> filteredList = snapshot.data.credits.crew
                    .where((element) => element.job == "Director")
                    .toList();
                print("TEM ${filteredList.length}");

                var runtimeFormated =
                    snapshot.data.runtime.toString().split("");
                var fmf = FlutterMoneyFormatter(
                    amount: snapshot.data.budget.toDouble(),
                    settings: MoneyFormatterSettings(
                        thousandSeparator: '.',
                        decimalSeparator: ',',
                        symbolAndNumberSeparator: ' ',
                        fractionDigits: 3,
                        compactFormatType: CompactFormatType.short));

                return Container(
                  color: DesignColors.COLOR_WHITE_DARK,
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Container(
                        height: height,
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Container(
                          height: height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              VoteAverageScale(
                                voteAverage: "${snapshot.data.voteAverage} ",
                              ),
                              MovieTitle(
                                title: snapshot.data.title,
                              ),
                              OriginalMovieTitle(
                                title: snapshot.data.originalTitle,
                              ),
                              Container(
                                width: width,
                                padding: EdgeInsets.all(10),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  children: [
                                    MovieDetailsFlag(
                                      name: "Duração: ",
                                      runtimeFormated: snapshot.data.releaseDate
                                          .substring(0, 4),
                                    ),
                                    MovieDetailsFlag(
                                        name: "Ano: ",
                                        runtimeFormated:
                                            "${runtimeFormated[0]}h ${runtimeFormated[1]}${runtimeFormated[2]} min"),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(bottom: 20),
                                child: Center(
                                  child: SizedBox(
                                    height: 120,
                                    width: width - 100,
                                    child: GridView.builder(
                                        gridDelegate:
                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 2,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.genres.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Container(
                                              height: 20,
                                              child: ButtonTheme(
                                                minWidth: 180.0,
                                                height: 20.0,
                                                hoverColor: DesignColors
                                                    .COLOR_LIGHT_BLUE,
                                                padding: EdgeInsets.all(10),
                                                child: RaisedButton(
                                                  onPressed: () {},
                                                  elevation: 0,
                                                  color: DesignColors
                                                      .COLOR_LIGHT_BLUE,
                                                  child: AutoSizeText(
                                                    "${snapshot.data.genres[index].name}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: DesignFont
                                                            .montserrat,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                              DescriptionSection(
                                description: snapshot.data.overview,
                              ),
                              BudgetSection(
                                fmf: "${fmf.output.symbolOnLeft}",
                                name: "ORÇAMENTO: ",
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
                                            itemCount: filteredList.length,
                                            itemBuilder: (context, index) {
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
                                        height: 60,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot
                                                .data.credits.cast.length,
                                            itemBuilder: (context, index) {
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
          BackButtonDetails(),
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
