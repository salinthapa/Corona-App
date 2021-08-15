import 'dart:convert';

import 'package:coronaapp/constraint.dart';
import 'package:coronaapp/widgets/chart.dart';
import 'package:coronaapp/widgets/country_item.dart';
import 'package:coronaapp/widgets/show_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';

import 'model/country.dart';

class CovidScreen extends StatefulWidget {
  const CovidScreen({Key? key}) : super(key: key);

  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  List<Country> countries = [];

  int _selectedIndex = 0;

  Future<List<Country>> getCountrys() async {
    var countriesUri = Uri.parse("https://restcountries.eu/rest/v2/all");
    var response = await http.get(countriesUri);

    if (response.statusCode == 200) {
      dynamic result = json.decode(response.body);

      print(result);

      for (int i = 0; i < result.length; i++) {
        countries.add(Country(
          countryName: result[i]['name'],
          flag: result[i]['flag'],
        ));
      }
    }

    return countries;
  }

  @override
  void initState() {
    getCountrys();
    super.initState();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 150,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    color: Color(0xffEDF4F4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "5 Symptomps of Covid-19",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: kThemeColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Read More ...",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: kThemeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 1,
                  top: -30,
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Color(0xffEDF4F4), BlendMode.modulate),
                    child: Image(
                        height: 110,
                        width: 110,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            'https://self4society.mygov.in/wp-content/uploads/2020/10/mygov-10000000002121788992.jpg')),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TotalRecoveredChart(
                  totalCase: 100000,
                  totalRecovered: 90000,
                ),
                Column(
                  children: [
                    ShowTile(
                        value: "12356",
                        title: "Affected",
                        containerColor: Colors.blue.shade300,
                        textColor: Colors.blue.shade600),
                    SizedBox(
                      height: 5,
                    ),
                    ShowTile(
                        value: "100000",
                        title: "Total Recovered",
                        containerColor: Colors.blueGrey.shade300,
                        textColor: Colors.blueGrey.shade600),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select country",
                    style: TextStyle(
                      color: kThemeColor,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: kThemeColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 250,
                itemBuilder: (context, position) {
                  return CountryItem(
                    onPress: () {
                      print('test');
                    },
                    countryName: countries[position].countryName,
                    flagUrl: countries[position].flag,
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.blue,
          unselectedLabelStyle: TextStyle(
            color: Colors.blue,
          ),
          elevation: 20.0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
