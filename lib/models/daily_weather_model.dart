// To parse this JSON data, do
//
//     final weekWeatherModel = weekWeatherModelFromJson(jsonString);

import 'dart:convert';

List<DailyWeatherModel> weekWeatherModelFromJson(String str) => List<DailyWeatherModel>.from(json.decode(str).map((x) => DailyWeatherModel.fromJson(x)));

String weekWeatherModelToJson(List<DailyWeatherModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyWeatherModel {
  DailyWeatherModel({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
    this.rain,
  });

  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  DateTime dtTxt;
  Rain rain;

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) => DailyWeatherModel(
    dt: json["dt"],
    main: MainClass.fromJson(json["main"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: Clouds.fromJson(json["clouds"]),
    wind: Wind.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"].toDouble(),
    sys: Sys.fromJson(json["sys"]),
    dtTxt: DateTime.parse(json["dt_txt"]),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds.toJson(),
    "wind": wind.toJson(),
    "visibility": visibility,
    "pop": pop,
    "sys": sys.toJson(),
    "dt_txt": dtTxt.toIso8601String(),
    "rain": rain == null ? null : rain.toJson(),
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainClass {
  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Rain {
  Rain({
    this.the3H,
  });

  double the3H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json["3h"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H,
  };
}

class Sys {
  Sys({
    this.pod,
  });

  Pod pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: podValues.map[json["pod"]],
  );

  Map<String, dynamic> toJson() => {
    "pod": podValues.reverse[pod],
  };
}

enum Pod { D, N }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  MainEnum main;
  Description description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: mainEnumValues.map[json["main"]],
    description: descriptionValues.map[json["description"]],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainEnumValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": icon,
  };
}

enum Description { SCATTERED_CLOUDS, BROKEN_CLOUDS, OVERCAST_CLOUDS, CLEAR_SKY, LIGHT_RAIN }

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "light rain": Description.LIGHT_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum MainEnum { CLOUDS, CLEAR, RAIN }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN
});

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  double speed;
  int deg;
  double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toDouble(),
    deg: json["deg"],
    gust: json["gust"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
