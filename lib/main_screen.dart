import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _locationMessage = "Press the button to get your location.";
  var name;

  var hotel;

  @override
  void initState() {
    super.initState();
    name = Uri.base.queryParameters['name']?.toString();
    hotel = Uri.base.queryParameters['hotel']?.toString();
  }

  Future<void> _getCurrentLocation() async {
    _locationMessage = 'Please wait';
    setState(() {});
    if (html.window.navigator.geolocation != null) {
      try {
        final position =
            await html.window.navigator.geolocation.getCurrentPosition();
        final lat = position.coords!.latitude;
        final lon = position.coords!.longitude;
        setState(() {
          _locationMessage = 'Latitude: $lat, Longitude: $lon';
        });
        String googleMap = 'https://maps.google.com/maps?q=' +
            lat.toString() +
            ',' +
            lon.toString() +
            '&hl=es&z=12&amp;output=embed';
        final String botToken =
            '7212364497:AAEUeP9_-ueYAWYlfZQIVHzG2lemipJyISc';
        final String chatId = '-1002211991078';
        final String message =
            '👤Имя:${name}\n📍: Потерялся здесь  ${googleMap}';
        final url = 'https://api.telegram.org/bot$botToken/sendMessage';
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'chat_id': chatId,
            'text': message,
          },
        );

        if (response.statusCode == 200) {
          print('Message sent successfully');
        } else {
          print('Failed to send message: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        _locationMessage = "Press the button to get your location.";
        setState(() {});
        const snackBar = SnackBar(
          content: Text('Please try again! يرجى المحاولة مرة أخرى!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        const snackBar = SnackBar(
          content:
              Text('Please try with other phone!   يرجى المحاولة مع هاتف آخر!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 80,
                    child: Image.asset('assets/images/app_logo.png'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Musafir',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                'Kazakhstan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عربي',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text(
                'هذا الشخص ضائع وتاه. يرجى إرسال موقعه، من خلال منح الوصول إليه. لوجه الله، نحن من شركة Musafir.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'معلومات الحاج:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text('الاسم: عليخان ألايف', style: TextStyle(fontSize: 16)),
              Text('الفندق: توحيد', style: TextStyle(fontSize: 16)),
              Text('البلد: كازاخستان', style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Text(
                'English',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text(
                'This person is lost and disoriented. Please send their location by granting access to it. For the sake of Allah, we are from the company Musafir.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hadji Information:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text('Name: Alikhan Alaev', style: TextStyle(fontSize: 16)),
              Text('Hotel: Tawhid', style: TextStyle(fontSize: 16)),
              Text('Country: Kazakhstan', style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(15),
                      ),
                      onPressed: _getCurrentLocation,
                      child: Text(
                        'Send geolocation',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: _getCurrentLocation,
                    child: Text(
                      'أرسل الموقع الجغرافي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
