import 'package:flutter/material.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/stockDetail.dart';

class StockTable extends StatefulWidget {
  final List<Stock> stocks;

  const StockTable({Key key, this.stocks}) : super();

  @override
  StockTableState createState() => StockTableState();
}

class StockTableState extends State<StockTable> {
  List<Stock> _stocks;

  Color valueColour(Stock stock) {
    if (stock.priceDifference < 0) {
      return Color.fromRGBO(89, 211, 48, 1);
    }
    return Color.fromRGBO(220, 23, 17, 1);
  }

  Icon priceChangeIcon(Stock stock) {
    if (stock.priceDifference < 0) {
      return Icon(
        Icons.arrow_drop_down,
        color: valueColour(stock),
        size: 12,
      );
    }
    return Icon(
      Icons.arrow_drop_up,
      color: valueColour(stock),
      size: 12,
    );
  }

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
                  label: Text('Price Diff'),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                stock.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                stock.idNumber,
                                style: TextStyle(
                                    color: Color.fromRGBO(151, 153, 154, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                          onTap: () {toDetailPage(stock);}
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              stock.currentPrice.toStringAsFixed(2),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {toDetailPage(stock);},
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
                                  color: valueColour(stock),
                                ),
                              ),
                              Text(
                                (stock.pctPriceDifference * 100)
                                        .toStringAsFixed(2) +
                                    " %",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: valueColour(stock),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {toDetailPage(stock);},
                        ),
                        DataCell(
                          // triangle icon
                          priceChangeIcon(stock),
                          onTap: () {toDetailPage(stock);},
                        )
                      ],
                    ),
                  )
                  .toList(),
            )));
  }
}
