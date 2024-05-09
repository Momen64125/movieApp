import 'package:flutter/material.dart';
import 'package:movie_app/models/apiclass.dart';
import 'package:movie_app/screens/film%20datials.dart';
class Film extends StatefulWidget {

  const Film({required this.filmList,super.key});
  final List<Filmclass> filmList ;

  @override
  State<Film> createState() => _FilmState();
}

class _FilmState extends State<Film> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Movies',style: TextStyle(color: Colors.white),),),
        leading:
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:const Icon(Icons.arrow_back_ios),color: Colors.white,),
      ),
      body:
      ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: widget.filmList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(


                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>datiles(widget.filmList[index]),
                          ),
                        );
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${widget.filmList[index].backdrop_path}',
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.all(8),
                              child: Text(
                                widget.filmList[index].overview ?? 'Movie Title',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
