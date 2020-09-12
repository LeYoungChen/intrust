import 'package:flutter/material.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/stockDetail.dart';

class StockTable extends StatefulWidget {
  final List<Stock> stocks;

  const StockTable({
    Key key,
    this.stocks
  }) : super();

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
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('Stock No.'),
                ),
                DataColumn(
                  label: Text('Price'),
                ),
                DataColumn(
                  label: Text('Price/Pct Diff'),
                ),
                DataColumn(
                  label: Text(''),
                )
              ],
              rows: _stocks.map((stock) =>
                  DataRow(
                    cells: [
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                stock.name
                            ),
                            Text(
                                stock.idNumber
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StockDetail(
                                    stock: stock
                                );
                              },
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Text(stock.currentPrice.toStringAsFixed(2),),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StockDetail(
                                  stock: stock,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // colour by direction
                          children: <Widget>[
                            Text(
                              stock.priceDifference.toStringAsFixed(2),
                            ),
                            Text(
                              (stock.pctPriceDifference * 100).toStringAsFixed(2) + " %",
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StockDetail(
                                  stock: stock,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      DataCell(
                        // triangle icon
                        Text("^"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return StockDetail(
                                  stock: stock,
                                );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
              ).toList(),
            )
        )
    );
  }
}
