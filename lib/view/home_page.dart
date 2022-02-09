import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/bloc.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/event.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/state.dart';
import 'package:weather/view/search_screen.dart';
import 'city_weather_details_with_cityname.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    final citiesWeathersSummeryBloc = BlocProvider.of<CitiesWeathersSummeryBloc>(context);
    citiesWeathersSummeryBloc.add(FetchAllDataEvent());


    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage( ( int.parse(formattedTime) < 18 )
                          ? 'assets/images/sunny.png'
                          : 'assets/images/night.png'),
                      fit: BoxFit.fitWidth,
                    )
                ),
                child: BlocBuilder<CitiesWeathersSummeryBloc, CitiesWeathersSummeryState>(builder: (context, state){
                  if (state is CitiesWeathersSummeryIsLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CitiesWeathersSummeryIsLoadedState){
                    return state.getCitiesWeathers.length != 0
                        ? CityWeatherDetailsWithName(state.getCitiesWeathers[0].name , Icons.menu)
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No city data to show, please add a city and retry',
                            style: int.parse(formattedTime) < 18
                                ? TextStyle(color: Colors.black)
                                : TextStyle(color: Colors.white)),
                        MaterialButton(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Add city'),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchScreen()));
                            })
                      ],
                    );
                  }
                  if (state is CitiesWeathersSummeryIsNotLoadedState){
                    return Text(
                      '',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    );
                  }
                  return Center(child: Text("", style: TextStyle(fontSize: 25, color: Colors.white)));
                }
                )
            )
        )
    );
  }
}
