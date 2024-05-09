import 'package:flutter/material.dart';
import 'package:movie_app/models/apiclass.dart';
import 'package:movie_app/screens/film%20datials.dart';

class SearchScreen extends StatefulWidget {
  final List<Filmclass> filmList;

  SearchScreen({required this.filmList,super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  List<Filmclass> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String searchTerm) {
    setState(() {
      _searchResults = widget.filmList.where((Film) =>
      (Film.overview ?? '').toLowerCase().contains(searchTerm.toLowerCase()) ||
          (Film.origin_country ?? '').toLowerCase().contains(searchTerm.toLowerCase())).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black
      ,
      body: Column(
        children: [

          Padding(

            padding: const EdgeInsets.only(left: 10,right: 10,top: 50,bottom: 10),
            child: TextFormField(

              style: const TextStyle(
                color: Colors.white
              ),
             cursorColor: Colors.cyan,

              controller: _searchController,
              onChanged: (value) {
                _performSearch(value);
              },
              decoration: InputDecoration(

                fillColor: Colors.grey,
                hintText: 'Search',
             hintStyle: const TextStyle(color: Colors.white),
             suffixIcon: const Icon(Icons.dangerous_outlined,color: Colors.white,),
                prefixIcon: const Icon(Icons.search,color: Colors.white,),

                border: OutlineInputBorder(

                  borderSide: const BorderSide(color: Colors.black12),

                  borderRadius: BorderRadius.circular(15),

                ),

              ),

            ),
          ),
          Expanded(
            child:
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
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(


                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>datiles(_searchResults[index]),
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
                                      top:  Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/original/${_searchResults[index].backdrop_path}',
                                      fit: BoxFit.cover,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      _searchResults[index].overview ?? 'Movie Title',
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
          ),
        ],
      ),
    );
  }
}
