import 'package:flutter/material.dart';
import 'package:weather_app_flutter/models/weather_model.dart';
import 'package:weather_app_flutter/utils/location.dart';
import 'package:weather_app_flutter/views/main_screen_model.dart';

import 'package:weather_app_flutter/views/widgets/day_update_row_page.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherRepository _repository = WeatherRepository();
  WeatherModel? _weather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final location = await getLocation();
      final data = await _repository.fetchWeatherData(location: location);
      setState(() {
        _weather = WeatherModel.fromJson(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String getWeatherImage(String weatherCondition, String localTime) {
    DateTime utcTime = DateTime.parse(localTime);
    DateTime bangladeshTime = utcTime.add(Duration(hours: 6));
    final hour = bangladeshTime.hour;
    if (weatherCondition.toLowerCase().contains('sunny') ||
        weatherCondition.toLowerCase().contains('clear')) {
      return 'assets/image2.png';
    } else if (weatherCondition.toLowerCase().contains('rain')) {
      return 'assets/image4.png';
    } else if (weatherCondition.toLowerCase().contains('thunder') ||
        weatherCondition.toLowerCase().contains('lightning')) {
      return 'assets/image5.png';
    } else if (weatherCondition.toLowerCase().contains('storm')) {
      return 'assets/image3.png';
    } else if (hour >= 18 || hour < 6) {
      return 'assets/image6.png';
    } else {
      return 'assets/image1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _weather == null
              ? const Center(child: Text('Failed to load weather data'))
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF97ABFF), Color(0xFF123597)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          _weather!.location!.country!,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.white,
                            ),
                            Text(
                              _weather!.location!.name!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              getWeatherImage(
                                  _weather!.current!.condition!.text!,
                                  _weather!.location!.localtime!),
                              height: 145,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${_weather!.current!.tempC!.toString()}°',
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Partly Cloud - H:${_weather!.current!.humidity!}° L:${_weather!.current!.visKm!.toString()}°',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildWeatherTab('Today', true),
                            _buildWeatherTab('Next Days', false),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              _buildHourlyWeatherCard('Now', '13°',
                                  const AssetImage('assets/image1.png')),
                              _buildHourlyWeatherCard('4 PM', '14°',
                                  const AssetImage('assets/image2.png')),
                              _buildHourlyWeatherCard('5 PM', '12°',
                                  const AssetImage('assets/image3.png')),
                              _buildHourlyWeatherCard('6 PM', '8°',
                                  const AssetImage('assets/image4.png')),
                              _buildHourlyWeatherCard('7 PM', '9°',
                                  const AssetImage('assets/image5.png')),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFFFFF),
                                  Color(0x00FFFFFF),
                                ],
                                stops: [-1.14, 4.9764],
                              ),
                              borderRadius: BorderRadius.circular(250.0),
                              border: Border.all(
                                  color: Colors.transparent, width: 2.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DayUpdateRow(
                                    iconPath: 'assets/sun.png',
                                    label: 'Sunset',
                                    value: '5:51 PM',
                                  ),
                                  DayUpdateRow(
                                    iconPath: 'assets/sunDay.png',
                                    label: 'Sunrise',
                                    value: '7:00 AM',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildWeatherTab(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyWeatherCard(String time, String temp, AssetImage image) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: 65.85,
      height: 139,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          style: BorderStyle.solid,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.575),
            Color.fromRGBO(255, 255, 255, 0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Image(
            image: image,
            width: 49.85,
            height: 48,
          ),
          const SizedBox(height: 10),
          Text(
            temp,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
