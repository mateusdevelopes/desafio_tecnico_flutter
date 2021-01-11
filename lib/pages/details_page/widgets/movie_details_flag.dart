import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class MovieDetailsFlag extends StatelessWidget {
  const MovieDetailsFlag({
    Key key,
    @required this.runtimeFormated,
    this.name,
  }) : super(key: key);

  final String name;
  final String runtimeFormated;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignColors.COLOR_LIGHT_BLUE,
      padding: EdgeInsets.all(12),
      child: Wrap(
        children: [
          AutoSizeText(
            name,
            style: TextStyle(
                fontFamily: DesignFont.montserrat,
                fontWeight: FontWeight.w300,
                fontSize: 16),
          ),
          AutoSizeText(
            runtimeFormated,
            style: TextStyle(
                fontFamily: DesignFont.montserrat,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}