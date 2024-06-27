import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/main_modal.dart';
import '../../provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController _searchController = TextEditingController();
  late WeatherProvider _weatherProvider;

  @override
  void initState() {
    super.initState();
    _weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    _weatherProvider.fetchWeather("surat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String? selectedLocation = await showSearch<String>(
                context: context,
                delegate: WeatherSearchDelegate(_weatherProvider),
              );
              if (selectedLocation != null && selectedLocation.isNotEmpty) {
                // Handle selection if needed
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Implement settings functionality
            },
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (weatherProvider.weatherResponse != null) {
            final weather = weatherProvider.weatherResponse!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/loction_logo.png", height: 25,),
                          Text(" ${weather.location.region}, ${weather.location.country} ", style: TextStyle(fontSize: 21),)
                        ],
                      ),
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Weather',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${weather.current.condition.text}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${weather.current.tempC}°C',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Feels like ${weather.current.feelslikeC}°C',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  //Image.network('${weather.current.condition.icon}', height: 20, width: 30,),
                                  Text('${weather.current.condition.text}'),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.water_drop),
                                  Text('Humidity: ${weather.current.humidity}%'),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.wb_sunny),
                                  Text('UV Index: ${weather.current.uv}'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Hourly Forecast',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 120.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 12, // Replace with actual hourly forecast count
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('${index + 1} PM'),
                            Icon(Icons.cloud),
                            Text('${weather.current.tempC}°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Daily Forecast',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Replace with actual daily forecast count
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('Day ${index + 1}'),
                          subtitle: Text('Max: ${weather.current.tempC}°C / Min: ${weather.current.tempC}°C'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            // Navigate to detailed forecast page
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 40,),
                  SizedBox(height: 30,),
                  Text('Failed to load weather data'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}


class WeatherSearchDelegate extends SearchDelegate<String> {
  final WeatherProvider weatherProvider;

  WeatherSearchDelegate(this.weatherProvider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: weatherProvider.fetchWeather(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Show search results based on fetched data
          return buildWeatherResults(context, weatherProvider.weatherResponse!);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: weatherProvider.getSuggestions(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<String> suggestions = snapshot.data as List<String>;
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions[index]),
                onTap: () {
                  query = suggestions[index];
                  showResults(context);
                },
              );
            },
          );
        }
      },
    );
  }


  Widget buildWeatherResults(BuildContext context, WeatherResponse weather) {
    return ListView(
      children: [
        ListTile(
          title: Text('Current Weather for ${weather.location.name}'),
          subtitle: Text('Temperature: ${weather.current.tempC}°C'),
        ),
        ListTile(
          title: Text('Condition'),
          subtitle: Text('${weather.current.condition.text}'),
          leading: Image.network(
            weather.current.condition.icon,
            width: 50,
            height: 50,
          ),
        ),
        ListTile(
          title: Text('Feels Like'),
          subtitle: Text('${weather.current.feelslikeC}°C'),
        ),
        ListTile(
          title: Text('Wind'),
          subtitle: Text(
              '${weather.current.windKph} km/h ${weather.current.windDir}'),
        ),
        ListTile(
          title: Text('Humidity'),
          subtitle: Text('${weather.current.humidity}%'),
        ),
        ListTile(
          title: Text('UV Index'),
          subtitle: Text('${weather.current.uv}'),
        ),
      ],
    );
  }
}
