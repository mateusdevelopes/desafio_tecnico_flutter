import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_colors.dart';
import 'package:desafio_tecnico_flutter/shared/theme/design_fonts.dart';
import 'package:flutter/material.dart';

class BudgetSection extends StatelessWidget {
  const BudgetSection({
    Key key,
    @required this.fmf,
    this.name,
  }) : super(key: key);

  final String name;
  final String fmf;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      child: Container(
        padding: EdgeInsets.all(12),
        color: DesignColors.COLOR_LIGHT_BLUE,
        child: Row(
          children: [
            AutoSizeText(
              name,
              style: TextStyle(
                  fontFamily: DesignFont.montserrat,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
            AutoSizeText(
              fmf,
              style: TextStyle(
                  fontFamily: DesignFont.montserrat,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
