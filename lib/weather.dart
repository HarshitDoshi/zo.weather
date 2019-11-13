import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location.dart';

Future<Weather> fetchWeather() async {
  Location locationData = await fetchLocation();

  final response = await http.get(
    'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.currentLatitude}&lon=${locationData.currentLongitude}&units=metric&APPID=YOUR_API_KEY_HERE',
  );

  if (response.statusCode == 200) {
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch weather!');
  }
}

class Weather {
  final String city;
  final String country;
  final String summary;
  final Icon icon;
  final int temperature;
  final int tempMin;
  final int tempMax;
  final int humidity;
  final double wind;
  final int cloudliness;
  final int sunrise;
  final int sunset;
  final String timezone;

  Weather({
    this.city,
    this.country,
    this.summary,
    this.icon,
    this.temperature,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.wind,
    this.cloudliness,
    this.sunrise,
    this.sunset,
    this.timezone,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'] as String,
      country: json['sys']['country'] as String,
      //summary: json['weather']['main'] as String,
      //icon: json['weather']['icon'] as Icon,
      temperature: json['main']['temp'] as int,
      tempMin: json['main']['temp_min'] as int,
      tempMax: json['main']['temp_max'] as int,
      humidity: json['main']['humidity'] as int,
      wind: json['wind']['speed'] as double,
      cloudliness: json['clouds']['all'] as int,
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      //timezone: json['timezone'] as String,
    );
  }
}

class PlaceWidget extends StatefulWidget {
  @override
  _PlaceWidgetState createState() => new _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  Future<Weather> place;

  String degreeCelsius = '°C';

  @override
  void initState() {
    super.initState();
    place = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: place,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: RichText(
                  text: new TextSpan(
                    text: 'ZO',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 30.0,
                      color: Colors.black,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.white,
                          offset: Offset.fromDirection(0.0),
                          blurRadius: 10.0,
                        ),
                        Shadow(
                          color: Colors.white,
                          offset: Offset.fromDirection(0.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                        text: '.',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          fontStyle: FontStyle.normal,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                      new TextSpan(
                        text: 'WEATHER',
                        style: new TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //snapshot.data.icon,
                      Text(
                        '${snapshot.data.temperature.round()}$degreeCelsius',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.place,
                        color: Colors.black,
                        size: 15.0,
                      ),
                      Text(
                        '${snapshot.data.city}, ${snapshot.data.country}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                            Shadow(
                              color: Colors.white,
                              offset: Offset.fromDirection(0.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Location unavailable!');
        }
        return Text('Locating you...');
      },
    );
  }
}

class WeatherDisplay extends StatefulWidget {
  @override
  _WeatherDisplayState createState() => new _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay>
    with TickerProviderStateMixin {
  Future<Weather> weather;

  String degreeCelsius = '°C';

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            primary: false,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'High/Low',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${snapshot.data.tempMin}$degreeCelsius/${snapshot.data.tempMax}$degreeCelsius',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Humidity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${snapshot.data.humidity}%',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sunrise',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${DateTime.fromMillisecondsSinceEpoch(snapshot.data.sunrise * 1000).toLocal().hour}:${DateTime.fromMillisecondsSinceEpoch(snapshot.data.sunrise * 1000).toLocal().minute}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sunset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${DateTime.fromMillisecondsSinceEpoch(snapshot.data.sunset * 1000).toLocal().hour}:${DateTime.fromMillisecondsSinceEpoch(snapshot.data.sunset * 1000).toLocal().minute}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Wind',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${snapshot.data.wind.round()}m/s',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(0.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Cloudliness',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      '${snapshot.data.cloudliness.round()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Container();
        }
        return Container();
      },
    );
  }
}

/*
class TemperatureWidget extends StatefulWidget {
  @override
  _TemperatureWidgetState createState() => new _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text('${snapshot.data.temperature}'),
            color: Colors.transparent,
          );
        } else if (snapshot.error) {
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Placeholder(
          color: Colors.white,
          strokeWidth: 10.0,
        );
      },
      initialData: Weather(
        temperature: 0,
      ),
    );
  }
}

class HumidtyWidget extends StatefulWidget {
  @override
  _HumidtyWidgetState createState() => new _HumidtyWidgetState();
}

class _HumidtyWidgetState extends State<HumidtyWidget> {
  Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text('${snapshot.data.humidity}'),
            color: Colors.transparent,
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Placeholder(
          color: Colors.white,
          strokeWidth: 10.0,
        );
      },
      initialData: Weather(
        humidity: 0,
      ),
    );
  }
}

class SunriseWidget extends StatefulWidget {
  @override
  _SunriseWidgetState createState() => new _SunriseWidgetState();
}

class _SunriseWidgetState extends State<SunriseWidget> {
  Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text('${snapshot.data.sunrise}'),
            color: Colors.transparent,
          );
        } else if (snapshot.error) {
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Placeholder(
          color: Colors.white,
          strokeWidth: 10.0,
        );
      },
      initialData: Weather(
        humidity: 0,
      ),
    );
  }
}

class SunsetWidget extends StatefulWidget {
  @override
  _SunsetWidgetState createState() => new _SunsetWidgetState();
}

class _SunsetWidgetState extends State<SunsetWidget> {
  Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text('${snapshot.data.sunset}'),
            color: Colors.transparent,
          );
        } else if (snapshot.error) {
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Placeholder(
          color: Colors.white,
          strokeWidth: 10.0,
        );
      },
      initialData: Weather(
        humidity: 0,
      ),
    );
  }
}

class WindWidget extends StatefulWidget {
  @override
  _WindWidgetState createState() => new _WindWidgetState();
}

class _WindWidgetState extends State<WindWidget> {
  Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text('${snapshot.data.wind}'),
            color: Colors.transparent,
          );
        } else if (snapshot.error) {
          return Container(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Placeholder(
          color: Colors.white,
          strokeWidth: 10.0,
        );
      },
      initialData: Weather(
        wind: 0,
      ),
    );
  }
}
*/
