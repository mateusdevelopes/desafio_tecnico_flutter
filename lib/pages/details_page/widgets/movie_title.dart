import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 15),
      child: Container(
        child: AutoSizeText(
          title,
          style: TextStyle(
              fontFamily: DesignFont.montserrat,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
    );
  }
}