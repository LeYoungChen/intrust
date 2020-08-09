import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  final String title;
  final double price;
  final double priceDiff;
  final double pctDiff;
  final String indicator;
  final Function press;

  const Stock(
      {this.title,
      this.price,
      this.priceDiff,
      this.pctDiff,
      this.indicator,
      this.press});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "$title ",
                            ),
                            TextSpan(
                              text: "$price ",
                            ),
                            TextSpan(
                              text: "$priceDiff ",
                            ),
                            TextSpan(
                              text: "$pctDiff ",
                            ),
                          ]),
                        ))
                      ],
                    ))
              ],
            )),
          ));
    });
  }
}
