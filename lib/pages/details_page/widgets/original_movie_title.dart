import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class OriginalMovieTitle extends StatelessWidget {
  const OriginalMovieTitle({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            title,
            style: TextStyle(
                fontFamily: DesignFont.montserrat,
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}