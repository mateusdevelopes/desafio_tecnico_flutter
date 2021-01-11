import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class VoteAverageScale extends StatelessWidget {
  final String voteAverage;
  const VoteAverageScale({
    Key key,
    this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          voteAverage,
          style: TextStyle(
              fontFamily: DesignFont.montserrat,
              fontWeight: FontWeight.w700,
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
    );
  }
}
