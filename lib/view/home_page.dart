import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cities_summery_container_bloc.dart';
import 'city_weather_details_with_cityname.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final citiesWeathersSummeryBloc = BlocProvider.of<CitiesWeathersSummeryBloc>(context);
    citiesWeathersSummeryBloc.add(FetchAllDataEvent());


    return BlocBuilder<CitiesWeathersSummeryBloc, CitiesWeathersSummeryState>(builder: (context, state){
      if (state is CitiesWeathersSummeryIsLoadingState){
        return Center(child: CircularProgressIndicator());
      }
      if (state is CitiesWeathersSummeryIsLoadedState){
        return CityWeatherDetailsWithName(state.getCitiesWeathers[0].name);
      }
      if (state is CitiesWeathersSummeryIsNotLoadedState){
        return Text(
          '',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }
      return Center(child: Text("", style: TextStyle(fontSize: 25, color: Colors.white)));
      }
    );
  }
}
