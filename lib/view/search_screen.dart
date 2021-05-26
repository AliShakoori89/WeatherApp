import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/daily_weather_bloc.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather/view/city_weather_details.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState ();
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/weather_types.jpg'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstATop),
            )),
        child: SearchPage(hintText, focusNode)
      ),
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

  int _currentIndex=0;
  List cardList=[
    Item1(),
    Item2(),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white,),
              onPressed: (){
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Text('  Check the weather by the city',style: TextStyle(color: Colors.white,
                fontSize: 19),),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          cityInput(context, widget.hintText, widget.focusNode),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 50
                ),
                child: Text('My location', style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height / 40
                ),
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.height / 22,
                        height: MediaQuery.of(context).size.height / 22,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 120,
                        top: MediaQuery.of(context).size.height / 120
                      ),
                      child: Icon(Icons.location_on, color: Colors.white,),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.7,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardList.map((card){
                          return Builder(
                              builder:(BuildContext context){
                                return Container(
                                  height: MediaQuery.of(context).size.height/3.4,
                                  width: MediaQuery.of(context).size.height/2,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    color: Colors.grey[900],
                                    child: card,
                                  ),
                                );
                              }
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(cardList, (index, url) {
                      return Container(
                        width: MediaQuery.of(context).size.height/100,
                        height: MediaQuery.of(context).size.height/100,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 22,
          )
        ],
      ),
    );
  }

  Widget cityInput(BuildContext context, String hintText, FocusNode focusNode) {

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight:
          400 //put here the max height to which you need to resize the textbox
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height / 50,
            top: MediaQuery.of(context).size.height / 50,
            bottom: MediaQuery.of(context).size.height / 50,
            right: MediaQuery.of(context).size.height / 50),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: MediaQuery.of(context).size.height / 2.5,
            child: TextField(
              focusNode: focusNode,
              maxLines: null,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        CityWeatherDetails(this.cityNameController.text)));
                  },
                  icon: Icon(
                    Icons.search,
                    size: 25.0,
                    color: Colors.white,
                  ),),
                fillColor: Colors.transparent,
                filled: true,
                contentPadding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 30,
                  top: MediaQuery.of(context).size.height / 35,
                  bottom: MediaQuery.of(context).size.height / 60,),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 15.0, color: Colors.white,),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(color: Colors.white.withOpacity(0.5), width: 2)),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    borderSide: new BorderSide(color: Colors.white.withOpacity(0.5), width: 2)),
              ),
              cursorColor: Colors.white,
              textAlign: TextAlign.left,
              controller: this.cityNameController,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // Widget weatherTemperature(BuildContext context) {
  //   return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
  //     if (state is WeatherLoadingState) {
  //       return Center(child: CircularProgressIndicator());
  //     }
  //     if (state is WeatherIsLoadedState) {
  //       var kelvin = state.getWeather.main.temp;
  //       int celsius = (kelvin - 273.15).toInt();
  //       return Text(
  //         celsius.toString() + '°  C',
  //         style: TextStyle(fontSize: 25, color: Colors.white),
  //       );
  //     }
  //     if (state is WeatherIsNotLoadedState) {
  //       return Text(
  //         "City not Found",
  //         style: TextStyle(fontSize: 25, color: Colors.white),
  //       );
  //     }
  //     return Text("Nothing", style: TextStyle(fontSize: 25, color: Colors.white));
  //   });
  // }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Padding(
              //     padding: EdgeInsets.only(
              //       left: MediaQuery.of(context).size.height / 30,
              //       top: MediaQuery.of(context).size.height / 30,
              //     ),
              //     child: _SearchPageState().weatherTemperature(context),
              //   )
              // ),
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.add, color: Colors.white,))
            ],
          ),

          // Text(
          //     "Data",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 22.0,
          //         fontWeight: FontWeight.bold
          //     )
          // ),
          // Text(
          //     "Data",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 17.0,
          //         fontWeight: FontWeight.w600
          //     )
          // ),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(
          //     "Data",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 22.0,
          //         fontWeight: FontWeight.bold
          //     )
          // ),
          // Text(
          //     "Data",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 17.0,
          //         fontWeight: FontWeight.w600
          //     )
          // ),
        ],
      ),
    );
  }
}