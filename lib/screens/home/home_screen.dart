import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twisun/models/user_location.dart';
import 'package:twisun/screens/home/tab_1.dart';
import 'package:twisun/screens/home/tab_2.dart';
import 'package:twisun/screens/home/tab_3.dart';
import 'package:twisun/screens/home/tab_4.dart';
import 'package:twisun/services/location_service.dart';
import 'package:twisun/services/weather_service.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:twisun/constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    getKey();
  }

  void getKey() async {
    await weatherService.getApiKey();
    print(weatherService.apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/icons/title_icon.png',
            fit: BoxFit.contain,
            height: 35,
          ),
          actions: <Widget>[
            Center(
                child: Text(
              "120",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            )),
            IconButton(
              icon: Icon(
                Icons.monetization_on_outlined,
                color: Colors.amber,
                size: 30,
              ),
              onPressed: () {
                //TODO cantidad de puntos
              },
            )
          ],
        ),
        body: Container(
          height: context.percentHeight * 81,
          child: VStack([
            VxBox().make(),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: VxBox(
                  child: VStack([
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    color: Colors.grey[350],
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.indigo[900],
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: Colors.grey[100],
                      labelPadding: Vx.m16,
                      tabs: [
                        Icon(Icons.home, size: 30),
                        Icon(Icons.wb_sunny, size: 30),
                        Icon(Icons.emoji_events, size: 30),
                        Icon(Icons.settings, size: 30),
                      ],
                    ),
                  ),
                ),
                TabBarView(
                  controller: _tabController,
                  children: [
                    GeneralTab(),
                    StreamProvider<UserLocation>.value(
                      initialData: UserLocation(),
                      value: LocationService().locationStream,
                      child: ForecastTab(),
                    ),
                    SolarPointsTab(),
                    SettingsTab(),
                  ],
                ).expand(),
              ])).white.make(),
            ).expand()
          ]),
        ),
        bottomSheet: Container(
          color: kPrimaryColor,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Renault SOFASA",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
