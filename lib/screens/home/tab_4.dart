import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:twisun/constants.dart';
import 'package:dotted_line/dotted_line.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
class GeneralTab extends StatelessWidget {
  const GeneralTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var electric = [
      BatteryLevel("level", 33, kPrimaryColor),
    ];
    var solar = [
      BatteryLevel("level", 29, Colors.amber),
    ];
    var empty = [
      BatteryLevel("level", 38, kSecondaryColor),
    ];

    var series = [
      charts.Series(
        domainFn: (BatteryLevel levels, _) => levels.energyType,
        measureFn: (BatteryLevel levels, _) => levels.value,
        colorFn: (BatteryLevel levels, _) => levels.color,
        id: 'Levels',
        data: electric,
        labelAccessorFn: (BatteryLevel levels, _) =>
            '${levels.value.toString()}%',
      ),
      charts.Series(
        domainFn: (BatteryLevel levels, _) => levels.energyType,
        measureFn: (BatteryLevel levels, _) => levels.value,
        colorFn: (BatteryLevel levels, _) => levels.color,
        id: 'Levels',
        data: solar,
        labelAccessorFn: (BatteryLevel levels, _) =>
            '${levels.value.toString()}%',
        insideLabelStyleAccessorFn: (BatteryLevel levels, _) =>
            new charts.TextStyleSpec(fontSize: 20, color: charts.Color.black),
      ),
      charts.Series(
        domainFn: (BatteryLevel levels, _) => levels.energyType,
        measureFn: (BatteryLevel levels, _) => levels.value,
        colorFn: (BatteryLevel levels, _) => levels.color,
        id: 'Levels',
        data: empty,
        // labelAccessorFn: (BatteryLevel levels, _) =>  '${levels.value.toString()}%',
        labelAccessorFn: (BatteryLevel levels, _) => '',
      )
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator<String>(
          labelAnchor: charts.BarLabelAnchor.middle,
          insideLabelStyleSpec:
              charts.TextStyleSpec(fontSize: 20, color: charts.Color.white)),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      layoutConfig: charts.LayoutConfig(
        topMarginSpec: new charts.MarginSpec.fixedPixel(0),
        leftMarginSpec: new charts.MarginSpec.fixedPixel(20),
        bottomMarginSpec: new charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: new charts.MarginSpec.fixedPixel(20),
      ),
      behaviors: [
        new charts.PercentInjector(
            totalType: charts.PercentInjectorTotalType.domain)
      ],
      // defaultRenderer: charts.BarRendererConfig(
      //     cornerStrategy: const charts.ConstCornerStrategy(5)),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text(
                  "Twizy autonomy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 60,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/twizy_icon.png',
                          fit: BoxFit.contain,
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          //width: 300,
                          child: DottedLine(
                            dashColor: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Image.asset(
                      'assets/icons/lightning_icon.png',
                      fit: BoxFit.contain,
                      height: 35,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Text("43.4 km",
                        style: TextStyle(color: kPrimaryColor, fontSize: 28)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              BatteryLevelBar(chart: chart),
              SizedBox(
                height: 5,
              ),
              BatteryStatus(),
            ],
          ),
        ),
      ),
    );
  }
}

class BatteryStatus extends StatefulWidget {
  @override
  _BatteryStatusState createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {
  String imgurl = 'assets/images/battery_today.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                  child: Text("Today"),
                  splashColor: kPrimaryColor,
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      imgurl = 'assets/images/battery_today.png';
                    });
                  }),
              RaisedButton(
                  child: Text("Week"),
                  splashColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      imgurl = 'assets/images/battery_week.png';
                    });
                  }),
              RaisedButton(
                  child: Text("Total"),
                  splashColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      imgurl = 'assets/images/battery_total.png';
                    });
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Image.asset(
                imgurl,
                fit: BoxFit.scaleDown,
                // height: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BatteryLevelBar extends StatelessWidget {
  const BatteryLevelBar({
    Key key,
    @required this.chart,
  }) : super(key: key);

  final charts.BarChart chart;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Battery Level: 62%",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 27),
            ),
          ),
          Container(
            child: chart,
            height: 90,
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            alignment: Alignment.topLeft,
          ),
          // ShapeOfView(
          //   shape: RoundRectShape(
          //     borderRadius: BorderRadius.circular(5),
          //     borderColor: Colors.red,
          //     borderWidth: 2,
          //   ),
          //   child: chart,
          //   height: 90,
          // ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Electrical energy",
                  style: TextStyle(color: kPrimaryColor),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Solar Energy",
                  style: TextStyle(color: kPrimaryColor),
                )
              ],
            ),
          ),
        ],
      ),
      //height: 125,
      alignment: Alignment.topLeft,
    );
  }
}

class BatteryLevel {
  final String energyType;
  final int value;
  final charts.Color color;

  BatteryLevel(this.energyType, this.value, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
*/