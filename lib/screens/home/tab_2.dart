import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:twisun/constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:twisun/models/user_location.dart';
import 'package:twisun/models/weather_model.dart';
import 'package:twisun/services/weather_service.dart';

class ForecastTab extends StatelessWidget {
  WeatherService weatherService = WeatherService();
  WeatherModel weather = WeatherModel();

  //Test
  List<charts.Series> seriesList;

  //test
  @override
  Widget build(BuildContext context) {
    UserLocation userLocation = Provider.of<UserLocation>(context);
    getWeather(userLocation);
    // return Scaffold(
    //   body: Center(
    //     child: Text(
    //         'Location: Lat: ${userLocation.latitude} & lon: ${userLocation.longitude}'),
    //   ),
    // );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 1000,
        padding: EdgeInsets.all(8),
        child: new charts.LineChart(
          seriesList,
          animate: true,
          // behaviors: [
          //   // Add the sliding viewport behavior to have the viewport center on the
          //   // domain that is currently selected.
          //   new charts.SlidingViewport(),
          //   // A pan and zoom behavior helps demonstrate the sliding viewport
          //   // behavior by allowing the data visible in the viewport to be adjusted
          //   // dynamically.
          //   new charts.PanAndZoomBehavior(),
          // ],
          defaultRenderer:
              new charts.LineRendererConfig(includeArea: true, stacked: true),
          // Set an initial viewport to demonstrate the sliding viewport behavior on
          // initial chart load.
          // domainAxis: new charts.OrdinalAxisSpec(
          //     viewport: new charts.OrdinalViewport('2018', 4)),
        ),
      ),
    );
  }

  void getWeather(UserLocation location) async {
    if (weatherService.apiKey == null) {
      await weatherService.getApiKey();
    }
    if (location.latitude != null && location.longitude != null) {
      if (weatherService.location == null) {
        weatherService.location = location;
        weather = await weatherService.getWeather(location);
        seriesList = getData(weather);
        print(
            '${weather.toString()} lat: ${location.latitude} lon: ${location.longitude}');
      } else {
        if (location.latitude != weatherService.location.latitude &&
            location.longitude != weatherService.location.longitude) {
          weatherService.location = location;
          weather = await weatherService.getWeather(location);
          seriesList = getData(weather);
          print(
              '${weather.toString()} lat: ${location.latitude} lon: ${location.longitude}');
        }
      }
    }
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<Current, DateTime>> getData(WeatherModel weather) {
    final hourly = weather.hourly;

    return [
      new charts.Series<Current, DateTime>(
        id: 'temp',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (Current current, _) => current.date,
        measureFn: (Current current, _) => current.temp,
        data: hourly,
      ),
      new charts.Series<Current, DateTime>(
        id: 'uvi',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (Current current, _) => current.date,
        measureFn: (Current current, _) => current.uvi,
        data: hourly,
      ),
    ];
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
                        Icon(
                          Icons.electric_car,
                          color: kPrimaryColor,
                          size: 40,
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
                    child: Icon(
                      Icons.flash_on_rounded,
                      color: Colors.amber,
                      size: 40,
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
            ],
          ),
        ),
      ),
    );
  }
}

// class GeneralTab extends StatefulWidget {
//   @override
//   _GeneralTabState createState() => _GeneralTabState();
// }

// class _GeneralTabState extends State<GeneralTab> {
//   @override
//   Widget build(BuildContext context) {
//     var electric = [
//       BatteryLevel("level", 33, kPrimaryColor),
//     ];
//     var solar = [
//       BatteryLevel("level", 29, Colors.amber),
//     ];
//     var empty = [
//       BatteryLevel("level", 38, kSecondaryColor),
//     ];

//     var series = [
//       charts.Series(
//         domainFn: (BatteryLevel levels, _) => levels.energyType,
//         measureFn: (BatteryLevel levels, _) => levels.value,
//         colorFn: (BatteryLevel levels, _) => levels.color,
//         id: 'Levels',
//         data: electric,
//         labelAccessorFn: (BatteryLevel levels, _) =>
//             '${levels.value.toString()}%',
//       ),
//       charts.Series(
//         domainFn: (BatteryLevel levels, _) => levels.energyType,
//         measureFn: (BatteryLevel levels, _) => levels.value,
//         colorFn: (BatteryLevel levels, _) => levels.color,
//         id: 'Levels',
//         data: solar,
//         labelAccessorFn: (BatteryLevel levels, _) =>
//             '${levels.value.toString()}%',
//         insideLabelStyleAccessorFn: (BatteryLevel levels, _) =>
//             new charts.TextStyleSpec(fontSize: 20, color: charts.Color.black),
//       ),
//       charts.Series(
//         domainFn: (BatteryLevel levels, _) => levels.energyType,
//         measureFn: (BatteryLevel levels, _) => levels.value,
//         colorFn: (BatteryLevel levels, _) => levels.color,
//         id: 'Levels',
//         data: empty,
//         // labelAccessorFn: (BatteryLevel levels, _) =>  '${levels.value.toString()}%',
//         labelAccessorFn: (BatteryLevel levels, _) => '',
//       )
//     ];

//     var chart = charts.BarChart(
//       series,
//       animate: true,
//       vertical: false,
//       barGroupingType: charts.BarGroupingType.stacked,
//       barRendererDecorator: charts.BarLabelDecorator<String>(
//           labelAnchor: charts.BarLabelAnchor.middle,
//           insideLabelStyleSpec:
//               charts.TextStyleSpec(fontSize: 20, color: charts.Color.white)),
//       domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
//       primaryMeasureAxis:
//           charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
//       layoutConfig: charts.LayoutConfig(
//         topMarginSpec: new charts.MarginSpec.fixedPixel(0),
//         leftMarginSpec: new charts.MarginSpec.fixedPixel(20),
//         bottomMarginSpec: new charts.MarginSpec.fixedPixel(0),
//         rightMarginSpec: new charts.MarginSpec.fixedPixel(20),
//       ),
//       behaviors: [
//         new charts.PercentInjector(
//             totalType: charts.PercentInjectorTotalType.domain)
//       ],
//       // defaultRenderer: charts.BarRendererConfig(
//       //     cornerStrategy: const charts.ConstCornerStrategy(5)),
//     );
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
//                 child: Text(
//                   "Twizy autonomy",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: kPrimaryColor,
//                       fontSize: 28),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     flex: 60,
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.electric_car,
//                           color: kPrimaryColor,
//                           size: 40,
//                         ),
//                         Container(
//                           padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                           //width: 300,
//                           child: DottedLine(
//                             dashColor: kSecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     flex: 10,
//                     child: Icon(
//                       Icons.flash_on_rounded,
//                       color: Colors.amber,
//                       size: 40,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 30,
//                     child: Text("43.4 km",
//                         style: TextStyle(color: kPrimaryColor, fontSize: 28)),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               BatteryLevelBar(chart: chart),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
