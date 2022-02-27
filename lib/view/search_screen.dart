import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:weather/view/city_weather_details_with_citylocation.dart';
import 'dart:ui' as ui;
import 'package:weather/view/search_city_result_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Search city';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SearchPage(hintText, focusNode),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  final String hintText;
  final FocusNode focusNode;

  SearchPage(this.hintText, this.focusNode);

  @override
  State<SearchPage> createState() => _SearchPageState(hintText, focusNode);
}

class _SearchPageState extends State<SearchPage> {
  final String hintText;
  final FocusNode focusNode;

  var position = new Geo.Position();

  final TextEditingController cityNameController = TextEditingController();

  Geo.Position _currentPosition;

  final Location location = Location();

  _SearchPageState(this.hintText, this.focusNode);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '  Check the weather by the city',
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 100),
        cityInput(
            context, widget.hintText, widget.focusNode, cityNameController),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
      ],
    );
  }

  Widget cityInput(BuildContext context, String hintText, FocusNode focusNode,
      TextEditingController cityNameController) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight:
              400 //put here the max height to which you need to resize the textbox
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
                  width: MediaQuery.of(context).size.height / 2.1,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchCityResultPage(
                              this.cityNameController.text, Icons.add)));
                    },
                    focusNode: focusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (cityNameController.text.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchCityResultPage(
                                    this.cityNameController.text, Icons.add)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.white,
                              content: const Text(
                                'Please enter city name',
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 1),
                            ));
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          size: 20.0,
                          color: Colors.white,
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
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide:
                              new BorderSide(color: Colors.white, width: 1)),
                    ),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.left,
                    controller: this.cityNameController,
                    style: TextStyle(color: Colors.white),
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
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  FocusScope.of(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CityWeatherDetailsWithCityLocation()));
                }),
          )
        ],
      ),
    );
  }
}
