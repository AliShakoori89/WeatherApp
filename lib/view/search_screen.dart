import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/hourly_weather_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/database/database.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:weather/view/city_weather_details_with_citylocation.dart';
import 'package:weather/view/city_weather_details_with_cityname.dart';
import 'dart:ui' as ui;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Search city';
  String formattedTime = DateFormat('kk').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = 'Search city';
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (BuildContext context) =>
                        WeatherBloc(WeatherRepository())),
                BlocProvider(
                    create: (BuildContext context) =>
                        WeatherDetailsBloc(WeatherRepository())),
              ],
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage((int.parse(formattedTime) < 18)
                          ? 'assets/images/sunny.png'
                          : 'assets/images/night.png'),
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    )),
                child: SearchPage(hintText, focusNode),
              ))),
    );
  }
}

class SearchPage extends StatefulWidget {
  final String hintText;
  FocusNode focusNode;

  SearchPage(this.hintText, this.focusNode);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController cityNameController = TextEditingController();

  var db = new DatabaseHelper();

  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    return Column(
      children: [
        Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0))),
                    offset: Offset(0, 50),
                    icon: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 20
                      ),
                      child: Icon(Icons.menu, color: Colors.black87),
                    ),
                    color: Colors.black54.withOpacity(0.2),
                    itemBuilder: (context) {
                      return List.generate(1, (index) {
                        return PopupMenuItem(
                          child: InkWell(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height / 30),
                                Center(child: Text('Help')),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).size.height / 3,
                                        left: MediaQuery.of(context).size.height / 30,
                                        right: MediaQuery.of(context).size.height / 30,
                                      ),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                              style:
                                              ElevatedButton.styleFrom(
                                                primary: Colors.white30,
                                                onPrimary: Colors.black,
                                                shape: const BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(25))),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('ok')),
                                        )
                                      ],
                                      content: Text(
                                          'Just longpress on the city card to '
                                              'delete the weather summary'),
                                      backgroundColor:
                                      Colors.grey.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25)),
                                    );
                                  });
                            },
                          ),
                        );
                      });
                    })),
            SizedBox(
              height: MediaQuery.of(context).size.height /2.5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  Check the weather by the city',
                style: TextStyle(
                    color: (int.parse(formattedTime) < 18)
                        ? Colors.black87
                        : Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 100),
            cityInput(context, widget.hintText, widget.focusNode, formattedTime),
            SizedBox(height: MediaQuery.of(context).size.height / 20,),
          ],
        ),
        citySummaryCard(formattedTime),
      ],
    );
  }

  FutureBuilder<List<dynamic>> citySummaryCard(String formattedTime) {

    return FutureBuilder(
      future: db.getAllCityWeather(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 4.0,
            color: Colors.white,
          ));
        }
        return Flexible(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final time = snapshot.data[index].time;
                  final icon = snapshot.data[index].icon;
                  final temp = snapshot.data[index].temp;
                  final tempMax = snapshot.data[index].tempMax;
                  final tempMin = snapshot.data[index].tempMin;
                  final feelsLike = snapshot.data[index].feelsLike;
                  final name = snapshot.data[index].name;

                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 400,
                        bottom: MediaQuery.of(context).size.height / 80,
                        left: MediaQuery.of(context).size.height / 80,
                        right: MediaQuery.of(context).size.height / 80),
                    child: InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.height / 5,
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[800].withOpacity(0.6),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height / 80,
                                          left: MediaQuery.of(context).size.height / 80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          name.toString(),
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height / 180,
                                          left: MediaQuery.of(context).size.height / 80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${new DateFormat.MMMMd().format(DateTime(time))}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      20),
                              child: SvgPicture.asset(
                                "assets/svgs/" + "$icon" + ".svg",
                                width: 65.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      60),
                              child: Text(
                                '${fahrenheitToCelsius(temp)} °C',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height / 30,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 80,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward_sharp,
                                          size: 18,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          '${fahrenheitToCelsius(tempMax)} °C',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 80,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                        Text(
                                          '${fahrenheitToCelsius(tempMin)} °C',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.height / 80),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height / 70,
                                      ),
                                      Text('Real feel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height / 80,
                                      ),
                                      Text(
                                          '${fahrenheitToCelsius(feelsLike)} °C',
                                          style: TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      onLongPress: () {
                        final weatherBloc =
                        BlocProvider.of<WeatherBloc>(context);
                        weatherBloc.add(DeleteCityForWeatherEvent(
                            snapshot.data[index].name));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CityWeatherDetailsWithName(snapshot.data[index].name)));
                      },
                    ),
                  );
                }
            )
        );
      },
    );
  }

  fahrenheitToCelsius(double degree) {
    int celsious = (degree - 273.15).toInt();
    return celsious;
  }

  Widget cityInput(BuildContext context, String hintText, FocusNode focusNode,
      String formattedTime) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 400 //put here the max height to which you need to resize the textbox
          ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 100,
                  top: MediaQuery.of(context).size.height / 50,
                  bottom: MediaQuery.of(context).size.height / 200,
                  right: MediaQuery.of(context).size.height / 500),
              child: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Container(
                  width: MediaQuery.of(context).size.height / 2.5,
                  child: TextField(
                    focusNode: focusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CityWeatherDetailsWithName(
                                  this.cityNameController.text)));
                        },
                        icon: Icon(
                          Icons.search,
                          size: 20.0,
                          color: (int.parse(formattedTime) < 18)
                              ? Colors.black87
                              : Colors.white,
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 30,
                        top: MediaQuery.of(context).size.height / 35,
                        bottom: MediaQuery.of(context).size.height / 60,
                      ),
                      hintText: hintText,
                      hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: (int.parse(formattedTime) < 18)
                              ? Colors.black87
                              : Colors.white,
                          fontWeight: FontWeight.w300),
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(
                              color: (int.parse(formattedTime) < 18)
                                  ? Colors.black87
                                  : Colors.white,
                              width: 1)),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(
                              color: (int.parse(formattedTime) < 18)
                                  ? Colors.black87
                                  : Colors.white,
                              width: 1)),
                    ),
                    cursorColor: (int.parse(formattedTime) < 18)
                        ? Colors.black87
                        : Colors.white,
                    textAlign: TextAlign.left,
                    controller: this.cityNameController,
                    style: TextStyle(
                        color: (int.parse(formattedTime) < 18)
                            ? Colors.black87
                            : Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height / 400,
                top: MediaQuery.of(context).size.height / 100),
            child: IconButton(
              icon: Icon(
                Icons.location_on,
                size: 22,
              ),
              color: (int.parse(formattedTime) < 18)
                  ? Colors.black87
                  : Colors.white,
              onPressed: () async {

                await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.best,
                    forceAndroidLocationManager: true)
                    .then((Position position) {
                  setState(() {
                    _currentPosition = position;
                  });
                }).catchError((e) {
                  print(e);
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CityWeatherDetailsWithCityLocation(
                        _currentPosition.latitude,
                        _currentPosition.longitude)));
              },
            ),
          )
        ],
      ),
    );
  }
}

