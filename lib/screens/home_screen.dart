
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/apiclass.dart';
import 'package:movie_app/screens/film.dart';
import 'package:movie_app/screens/search.dart';

List<Filmclass> filmList = [];

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  getDaata() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=ead438549d84ac5007577789755ac6b6'));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      setState(() {
        List data = res['results'];
        for (int i = 0; i < data.length; i++) {
          filmList.add(Filmclass.fromJson(data[i]));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDaata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children:[

              Container(
               width: double.infinity,
               height:500,
               child: Image.network(
                'https://image.tmdb.org/t/p/w370_and_h556_bestv2/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
                width: double.infinity,

                fit: BoxFit.cover,
              ),
            ),
              Positioned(
                left: 7,
                right: 330,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.menu,color: Colors.white,),

                  ),

                ),

              ),
              Positioned(
                left: 330,
                right: 5,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search_sharp,size: 30,color: Colors.white,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen(filmList:filmList,)),
                      );

                    },
                  ),
                ),
              ),


              ),
      ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoContainer(Icons.info, 'INFO', Colors.black38),
              _buildInfoContainer(Icons.play_circle, 'TRAILER', Colors.black45),
              _buildInfoContainer(null, 'Play', Colors.red),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10), // Add some padding at the start
                ..._buildFilmList(), // Use a method to build the Film list
              ],
            ),
          ),
        ],
      ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.black12,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,

    items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: 'Home',

    ),

      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'favorites',

      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.airplane_ticket),
        label: 'ticket',

      ),


    ],),
    );
  }

  List<Widget> _buildFilmList() {
    List<Widget> widgets = [];
    for (int index = 0; index < filmList.length && index < 10; index++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 150,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/${filmList[index].backdrop_path}',
                width: 150,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
    // Add "See More" button
    widgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 150,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Film(filmList:filmList,)),
              );
            },
            child: const Text(
              'See All',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    return widgets;
  }



  Widget _buildInfoContainer(IconData? icon, String text, Color color) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          SizedBox(width: icon != null ? 5 : 0),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

}
