
import 'package:flutter/material.dart';
import 'package:movie_app/models/apiclass.dart';

class datiles extends StatefulWidget {

 final Filmclass Films;
 const datiles(this.Films);



  @override
  State<datiles> createState() => _datilesState();
}

class _datilesState extends State<datiles> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: Colors.black,

      body:
      Column(
        children: [

          Image.network(
            'https://image.tmdb.org/t/p/original/${widget.Films.backdrop_path}',),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Column(
              children: [
                const Text('Length',style:  TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),),
                Text('${widget.Films.vote_count}',style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              ],
            ),
            Column(
              children: [
                const Text('Language',style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),),

                Text('${widget.Films.original_language}',style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              ],
            ),
              const Column(
              children: [
                Text('Status',style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),),

                Text('Released',style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              ],
            ),

          ],),

          Text(widget.Films.overview??
              'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.',style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          ),

        ],

      ),


    );
  }
}
