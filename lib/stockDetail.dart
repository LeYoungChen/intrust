import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/widgets/k_chart.dart';

class StockDetail extends StatefulWidget {
  final Stock stock;

  StockDetail({
    Key key,
    @required this.stock
  }) : super (key: key);

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> with TickerProviderStateMixin {
  
  List dShares = [3190234, 12102578, 18703570, 16053243, 13608938, 38764390, 7562806, 3465972, 11308243, 8456201, 31077999, 6782104, 7470434, 4583440, 16581977, 27723753, 28190894, 12362961, 9648900, 7372415, 6033970, 6770910, 8466804, 9497961, 10172901, 36011086, 36237054, 38750964, 21975493, 28608129, 76202683, 28666529, 71097091, 89427080, 36669449, 17477955, 10495634, 16383714, 20964157, 14332572, 20418513, 10826385, 17071209, 10845362, 14244087, 8144325, 10341735, 34135316, 72562510, 103506659, 47959769, 40824985, 60522212, 134374563, 54282192, 46455399, 30793913, 24299721, 63982149, 91916506, 25426385, 29081754, 40575082, 130239766, 127940064, 86932392, 39394700, 37805162, 34999362, 40419186, 35850656, 39849284, 23866220, 32471586, 46757310, 45047973, 22368075, 26450392, 35946384, 31337640, 54223806, 37727449, 34248465, 40902248, 63726232, 38247639, 73416673, 32329865, 30266285, 20805623, 38976781, 12241281, 30457140, 24909147, 20906821, 34717821, 30806771, 23261995, 47481008, 50951108, 32285643, 49226442, 32695245, 30990038, 20932812, 26349981, 103581867, 93503419, 58448746, 53117451, 37548778, 25116363, 27106590, 23694117, 19845496, 22630261, 13932252, 19823116, 15594296, 13103050, 12359884, 27605324, 25694093, 30466230, 14783842, 18781246, 20258623, 13509198, 13243762, 22242651, 38864042, 37109528, 17598358, 31246571, 18376839, 12726524, 13864850, 12728303, 15131009, 22584788, 11321475, 14974876, 7871472, 37667899, 66258006, 40662500, 40443866, 23020868, 46077670, 21426372, 23459648, 18117965, 18863122, 16702403, 9084278, 9744308, 21147575, 22105363, 24649505, 21947741, 14712475, 13396430, 8711253, 25095742, 15519623, 38585511, 22195417, 14409756, 10930602, 11102158, 8221169, 19868832, 9028613, 6076428, 8358882, 20600514, 25135726, 16509383, 17360648, 11877583, 21683114, 18492479, 26318603, 25610891, 26847249, 30957382, 30388043, 26637814, 30183669, 34696866, 27075139, 47941035, 19363381, 23393147, 33908444, 52693677, 50607348, 32391878, 36689474, 28400165, 30856563, 54826711, 37783307, 43421331, 24700407, 21027951, 40109851, 37651985, 23385517, 49086119, 42558512, 60269808, 28305137, 35076704, 32398151, 27562340, 25029901, 55826064, 63244865, 32556389, 28103611, 18420314, 39872828, 32430111, 47553176, 48489846, 29574542, 45673024, 45488630, 52581909, 40607901, 25165201, 44030064, 30697478, 26054660, 29246381, 29402500, 64183273, 23727329, 33127698, 41188127, 31380116, 36814842, 24560394];

  List wShares = [12102578, 7562806, 6782104, 28190894, 6770910, 36237054, 28666529, 10495634, 10826385, 8144325, 47959769, 46455399, 25426385, 86932392, 40419186, 46757310, 40902248, 73416673, 12241281, 30806771, 49226442, 103581867, 25116363, 13932252, 27605324, 20258623, 37109528, 13864850, 14974876, 40662500, 23459648, 9744308, 24649505, 25095742, 10930602, 6076428, 16509383, 26318603, 26637814, 19363381, 32391878, 30856563, 21027951, 42558512, 27562340, 32556389, 47553176, 52581909, 26054660, 33127698];

  List mShares = [28190894, 14332572, 25426385, 31337640, 32285643, 27605324, 37667899, 24649505, 16509383, 28400165, 32556389, 33127698];

  // fixme: ask Chuni, what to do with the mvAvg lines in week k-chart and month k-chart
  // fixme: wStockPrices and mSrockPrices need to be updated, currently taking the data for that date
  // fixme: wShares and mShares also need to be updated to be the sum of shares within that time range (also check with Chuni whether this is the right column LOL, shouldn't it be volume?)

  String selectedKChartRange = 'd';

  @override
  Widget build(BuildContext context) {

    Map<String, Widget> kCharts = <String, Widget>{
      'd': KChart(
        historicPrices: widget.stock.historicPrice,
        shares: dShares,
      ),
      'w': KChart(
        historicPrices: widget.stock.historicPrice,
        shares: wShares,
      ),
      'm': KChart(
        historicPrices: widget.stock.historicPrice,
        shares: mShares,
      )
    };

    return Scaffold(
      resizeToAvoidBottomPadding: false, 
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 239, 242, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(widget.stock.name + " (" + widget.stock.idNumber + ")"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // fixme: use Stack and Positioned to overlap the segmented control and the KChart
                // https://stackoverflow.com/questions/49838021/how-do-i-stack-widgets-overlapping-each-other-in-flutter
                // https://api.flutter.dev/flutter/widgets/Stack-class.html
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: CupertinoSlidingSegmentedControl(
                    groupValue: selectedKChartRange,
                    children: {
                      'd': Text(' D '),
                      'w': Text(' W '),
                      'm': Text(' M '),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        selectedKChartRange = value;
                      });
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 300,
                        width: double.infinity,
                        child: kCharts[selectedKChartRange]
                      ),
                    ],
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
