import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/bloc/cities_weather_bloc/bloc.dart';
import 'package:weather/bloc/cities_weather_bloc/event.dart';
import 'package:weather/bloc/cities_weather_bloc/state.dart';
import 'package:weather/component/day_time.dart';
import 'package:weather/view/city_weather_details_with_cityname.dart';
import 'package:weather/view/search_screen.dart';


class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _cityName;

  @override
  void initState() {
    super.initState();
    _loadCity();
  }

  _loadCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cityName = (prefs.getString('City_Name') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {

    final citiesWeatherBloc = BlocProvider.of<CitiesWeatherBloc>(context);
    citiesWeatherBloc.add(FetchAllDataEvent());


    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage((dayTime() < 16)
                          ? 'assets/images/sunny.png'
                          : (18 > dayTime())
                          ? 'assets/images/afternoon.png'
                          : 'assets/images/night.png'),
                      fit: BoxFit.fill,
                    )),
                child: BlocBuilder<CitiesWeatherBloc, CitiesWeatherState>(builder: (context, state){
                  if (state is CitiesWeatherIsLoadingState){
                    return Center(child: CircularProgressIndicator(
                      color: dayTime() < 18
                          ? Colors.black
                          : Colors.white,
                    ));
                  }
                  if (state is CitiesWeatherIsLoadedState){
                    if(state.getCitiesWeathers.length != 0){
                      return CityWeatherDetailsWithName( _cityName , Icons.menu);
                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No city data to show, please add a city and retry',
                              style: dayTime() < 18
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
                  }
                  if (state is CitiesWeatherIsNotLoadedState){
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
