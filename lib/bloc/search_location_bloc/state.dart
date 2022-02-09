import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart' as Geo;

class SearchLocationStat extends Equatable {
  @override

  List<Object> get props => throw[];
}

class SearchLocationIsLoadedState extends SearchLocationStat{

  final Geo.Position location;

  SearchLocationIsLoadedState(this.location);

  Geo.Position get getLocations => location;

  @override
  List<Object> get props => [location];
}



class SearchLocationError extends SearchLocationStat {
  final int errorCode;

  SearchLocationError(this.errorCode);
}

class SearchLocationLoadingState extends SearchLocationStat {}

class SearchLocationIsNotLoadedState extends SearchLocationStat {}

class SearchLocationEmpty extends SearchLocationStat {}