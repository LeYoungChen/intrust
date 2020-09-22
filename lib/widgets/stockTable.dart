import 'package:flutter/material.dart';
import 'package:intrust/dataclasses/Stock.dart';
import 'package:intrust/pages/stockDetail.dart';

class StockTable extends StatefulWidget {
  final List<Stock> stocks;

  const StockTable({Key key, this.stocks}) : super();

  @override
  StockTableState createState() => StockTableState();
}

class StockTableState extends State<StockTable> {
  List<Stock> _stocks;

  @override
  void initState() {
    super.initState();
    _stocks = widget.stocks;
  }

  @override
  Widget build(BuildContext context) {

    Function toDetailPage = (stock) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StockDetail(stock: stock);
          },
        ),
      );
    };

    return Row(children: [
      Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text('股票'),
                  ),
                  DataColumn(
                    label: Text('價格'),
                  ),
                  DataColumn(
                    label: Text('價差'),
                  ),
                  DataColumn(
                    label: Text(''),
                  )
                ],
                rows: _stocks
                    .map(
                      (stock) => DataRow(
                        cells: [
                          DataCell(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    stock.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    stock.idNumber,
                                    style: TextStyle(
                                        color: Color.fromRGBO(151, 153, 154, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ), onTap: () {
                            toDetailPage(stock);
                          }),
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                stock.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            onTap: () {
                              toDetailPage(stock);
                            },
                          ),
                          DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // colour by direction
                              children: <Widget>[
                                Text(
                                  stock.priceDifference.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: stock.valueColour,
                                  ),
                                ),
                                Text(
                                  (stock.pctPriceDifference * 100)
                                          .toStringAsFixed(2) +
                                      " %",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: stock.valueColour,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              toDetailPage(stock);
                            },
                          ),
                          DataCell(
                            // triangle icon
                            stock.priceChangeIcon,
                            onTap: () {
                              toDetailPage(stock);
                            },
                          )
                        ],
                      ),
                    )
                    .toList(),
              )))
    ]);
  }
}
