import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    Key key,
    this.description,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: AutoSizeText(
            "Descrição",
            style: TextStyle(
                fontFamily: DesignFont.montserrat,
                fontWeight: FontWeight.w300,
                fontSize: 16),
          ),
        ),
        AutoSizeText(
          description,
          style: TextStyle(
              fontFamily: DesignFont.montserrat,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      ],
    );
  }
}
