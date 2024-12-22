import 'package:flutter/material.dart';
import 'package:weather_app_flutter/views/widgets/day_update_row_page.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              const Text(
                'Dhaka',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.white,
                  ),
                  Text(
                    'Current Location',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/image1.png'),
                    height: 135,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '13°',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Text(
                'Partly Cloud - H:17° L:4°',
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
                    _buildHourlyWeatherCard(
                        'Now', '13°', const AssetImage('assets/image1.png')),
                    _buildHourlyWeatherCard(
                        '4 PM', '14°', const AssetImage('assets/image2.png')),
                    _buildHourlyWeatherCard(
                        '5 PM', '12°', const AssetImage('assets/image3.png')),
                    _buildHourlyWeatherCard(
                        '6 PM', '8°', const AssetImage('assets/image4.png')),
                    _buildHourlyWeatherCard(
                        '7 PM', '9°', const AssetImage('assets/image5.png')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DayUpdateRow(
                        iconPath: 'assets/sun.png',
                        label: 'Sunset',
                        value: '5:51 PM',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DayUpdateRow(
                        iconPath: 'assets/sunDay.png',
                        label: 'Sunset',
                        value: '5:51 PM',
                      ),
                    ),
                  ],
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
      margin: EdgeInsets.all(7),
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
