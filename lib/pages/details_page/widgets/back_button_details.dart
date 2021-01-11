import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio_tecnico_flutter/widgets/ink_wrapper.dart';
import 'package:flutter/material.dart';

class BackButtonDetails extends StatelessWidget {
  const BackButtonDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}