import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/bloc/fetch_all_cities/bloc.dart';
import 'package:weather/bloc/fetch_all_cities/event.dart';
import 'package:weather/bloc/fetch_all_cities/state.dart';
import 'package:weather/component/day_time.dart';
import 'package:weather/convert/convert_temperature.dart';
import 'package:weather/repositories/temprory_memory_repository.dart';
import 'package:weather/view/city_weather_details_with_cityname.dart';
import 'package:weather/view/home_page.dart';
import 'package:weather/view/search_city_result_page.dart';
import 'package:weather/view/search_screen.dart';

class CitiesMenu extends StatefulWidget{

  @override
  State<CitiesMenu> createState() => _CitiesMenuState();
}

class _CitiesMenuState extends State<CitiesMenu> {

  var isSelected = false;
  var mycolor = Colors.black;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {

    final fetchCitiesDataBloc = BlocProvider.of<FetchCitiesDataBloc>(context);
    fetchCitiesDataBloc.add(FetchCitiesDataWeatherEvent());

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<FetchCitiesDataBloc, FetchCitiesDataState>(
          builder: (context, state) {
        if (state is FetchCitiesDataIsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FetchCitiesDataIsLoadedState) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.getCitiesWeathers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  selected: isSelected,
                  title: Stack(
                    children: [
                      selectedIndex == index
                          ? IconButton(
                              onPressed: () {
                                final weatherBloc =
                                BlocProvider.of<FetchCitiesDataBloc>(context);
                                weatherBloc.add(DeleteCityForWeatherEvent(
                                    state.getCitiesWeathers[index].name));
                                print(state.getCitiesWeathers.length);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => CitiesMenu()));
                              },
                              icon: Icon(Icons.delete, color: Colors.white,))
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage((dayTime() < 16)
                                    ? 'assets/images/sunny.png'
                                    : (18 > dayTime())
                                    ? 'assets/images/afternoon.png'
                                    : 'assets/images/night.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height /
                                              80,
                                          left: MediaQuery.of(context)
                                              .size
                                              .height /
                                              80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.getCitiesWeathers[index].name
                                              .toString(),
                                          style: TextStyle(
                                              color: dayTime() < 18
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height /
                                              180,
                                          left: MediaQuery.of(context)
                                              .size
                                              .height /
                                              80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${new DateFormat.MMMMd().format(DateTime.fromMicrosecondsSinceEpoch(state.getCitiesWeathers[index].time))}',
                                          style: TextStyle(
                                              color: dayTime() < 16
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Row(
                                  children: [
                                    Text('Real feel',
                                        style: TextStyle(
                                            color: dayTime() < 16
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            '${ConvertTemperature().fahrenheitToCelsius(state.getCitiesWeathers[index].feelsLike)}',
                                            style: TextStyle(
                                                color: dayTime() < 16
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 20)),
                                        Text('°C',
                                            style: TextStyle(
                                                color: dayTime() < 16
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image.asset(
                            'assets/gifs/' +
                                '${state.getCitiesWeathers[index].icon}' +
                                '.gif',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    CityTemporaryMemory().savedCity(state.getCitiesWeathers[index].name);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SearchCityResultPage(state.getCitiesWeathers[index].name, Icons.menu_outlined)),
                          (Route<dynamic> route) => false,);
                  },
                  onLongPress:
                      () {
                    setState(() {
                      if (isSelected) {
                        selectedIndex = index;
                        mycolor=Colors.black;
                        isSelected = false;
                      } else {
                        selectedIndex = index;
                        mycolor=Colors.white;
                        isSelected = true;
                      }
                    });
                  },
                );
              });
        }
        if (state is FetchCitiesDataIsNotLoadedState) {
          return Text(
            '',
            style: TextStyle(fontSize: 25, color: Colors.white),
          );
        }
        return Center(
            child: Text("", style: TextStyle(fontSize: 25, color: Colors.white)));
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.add
        ),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

