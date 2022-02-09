import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/fetch_all_cities/bloc.dart';
import 'package:weather/bloc/fetch_all_cities/event.dart';
import 'package:weather/bloc/fetch_all_cities/state.dart';
import 'package:weather/convert/convert_temperature.dart';
import 'package:weather/view/home_page.dart';

class CitiesMenu extends StatefulWidget{

  @override
  State<CitiesMenu> createState() => _CitiesMenuState();
}

class _CitiesMenuState extends State<CitiesMenu> {

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

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
              scrollDirection: Axis.horizontal,
              itemCount: state.getCitiesWeathers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 18,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      highlightColor: Colors.red,
                      splashColor: Colors.red,
                      focusColor: Colors.red,
                      hoverColor: Colors.red,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage((int.parse(formattedTime) < 18)
                                ? 'assets/images/sunny.png'
                                : 'assets/images/night.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                          MediaQuery.of(context).size.height /
                                              80,
                                          left:
                                          MediaQuery.of(context).size.height /
                                              80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.getCitiesWeathers[index].name
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 25),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                          MediaQuery.of(context).size.height /
                                              180,
                                          left:
                                          MediaQuery.of(context).size.height /
                                              80),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${new DateFormat.MMMMd().format(DateTime.fromMicrosecondsSinceEpoch(state.getCitiesWeathers[index].time))}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 90,
                                ),
                                Row(
                                  children: [
                                    Text('Real feel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        '${ConvertTemperature().fahrenheitToCelsius(state.getCitiesWeathers[index].feelsLike)} °C',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset(
                                'assets/gifs/' +
                                    '${state.getCitiesWeathers[index].icon}' +
                                    '.gif',
                                height: 100,
                                width: 100,
                              ),
                            )
                          ],
                        ),
                      ),
                      onLongPress: () {
                        final weatherBloc =
                        BlocProvider.of<FetchCitiesDataBloc>(context);
                        weatherBloc.add(DeleteCityForWeatherEvent(
                            state.getCitiesWeathers[index].name));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                  )
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
    );
  }
}

