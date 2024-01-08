import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/database/dbforfavorite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/pages/add_recipe.dart';
import 'package:http/http.dart' as http;
import '../firstpage.dart';
import 'home.dart';
import 'favorite.dart';
import 'profile.dart';

void main() {
  runApp(new MaterialApp(home: new search()));
}

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  Map<String, bool> favStatusMap = {};
   bool getFavStatus(String idMeal) {
    return favStatusMap[idMeal] ?? false;
  }


  DatabaseFavService _databasefavService = DatabaseFavService();
  final firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  List<ModelSearch> list = <ModelSearch>[];
  String? text;
  final url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['meals'].forEach((e) {
      ModelSearch modelsearch = ModelSearch(
          idMeal: e['idMeal'],
          strMeal: e['strMeal'],
          strMealThumb: e['strMealThumb'],
          strArea: e['strArea'],
          strCategory: e['strCategory'],
          strInstructions: e['strInstructions'],
          strIngredient1: e['strIngredient1'],
          strIngredient2: e['strIngredient2'],
          strIngredient3: e['strIngredient3'],
          strIngredient4: e['strIngredient4'],
          strIngredient5: e['strIngredient5'],
          strIngredient6: e['strIngredient6'],
          strIngredient7: e['strIngredient7'],
          strIngredient8: e['strIngredient8'],
          strIngredient9: e['strIngredient9'],
          strIngredient10: e['strIngredient10'],
          strIngredient11: e['strIngredient11'],
          strIngredient12: e['strIngredient12'],
          strIngredient13: e['strIngredient13'],
          strIngredient14: e['strIngredient14'],
          strIngredient15: e['strIngredient15'],
          strIngredient16: e['strIngredient16'],
          strIngredient17: e['strIngredient17'],
          strIngredient18: e['strIngredient18'],
          strIngredient19: e['strIngredient19'],
          strIngredient20: e['strIngredient20'],
          strMeasure1: e['strMeasure1'],
          strMeasure2: e['strMeasure2'],
          strMeasure3: e['strMeasure3'],
          strMeasure4: e['strMeasure4'],
          strMeasure5: e['strMeasure5'],
          strMeasure6: e['strMeasure6'],
          strMeasure7: e['strMeasure7'],
          strMeasure8: e['strMeasure8'],
          strMeasure9: e['strMeasure9'],
          strMeasure10: e['strMeasure10'],
          strMeasure11: e['strMeasure11'],
          strMeasure12: e['strMeasure12'],
          strMeasure13: e['strMeasure13'],
          strMeasure14: e['strMeasure14'],
          strMeasure15: e['strMeasure15'],
          strMeasure16: e['strMeasure16'],
          strMeasure17: e['strMeasure17'],
          strMeasure18: e['strMeasure18'],
          strMeasure19: e['strMeasure19'],
          strMeasure20: e['strMeasure20']);
      setState(() {
        if (e['strMealThumb'] != null) {
          list.add(modelsearch);
           favStatusMap[modelsearch.idMeal.toString()] = false;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(85),
              child: Text(
                "Arama",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => firstpage()));
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Color.fromRGBO(154, 82, 26, 1),
                  size: 35,
                )),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // Add padding around the search bar
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),

                  // Use a Material design search bar
                  child: TextField(
                    onChanged: (v) {
                      text = v;
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                        iconColor: Color.fromRGBO(0, 0, 0, 1),
                        hintText: 'Arama...',

                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                          color: Color.fromRGBO(154, 82, 26, 1),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                          search: text,
                                        )));
                          },
                          color: Color.fromRGBO(154, 82, 26, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(154, 82, 26, 1)),
                            borderRadius: BorderRadius.circular(30))),
                    onEditingComplete: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    search: text,
                                  )));
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            primary: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              final x = list[i];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => DetailPage(
                                                img: x.strMealThumb,
                                                header: x.strMeal,
                                                area: x.strArea,
                                                category: x.strCategory,
                                                ins: x.strInstructions,
                                                ing1: x.strIngredient1,
                                                ing2: x.strIngredient2,
                                                ing3: x.strIngredient3,
                                                ing4: x.strIngredient4,
                                                ing5: x.strIngredient5,
                                                ing6: x.strIngredient6,
                                                ing7: x.strIngredient7,
                                                ing8: x.strIngredient8,
                                                ing9: x.strIngredient9,
                                                ing10: x.strIngredient10,
                                                ing11: x.strIngredient11,
                                                ing12: x.strIngredient12,
                                                ing13: x.strIngredient13,
                                                ing14: x.strIngredient14,
                                                ing15: x.strIngredient15,
                                                ing16: x.strIngredient16,
                                                ing17: x.strIngredient17,
                                                ing18: x.strIngredient18,
                                                ing19: x.strIngredient19,
                                                ing20: x.strIngredient20,
                                                meas1: x.strMeasure1,
                                                meas2: x.strMeasure2,
                                                meas3: x.strMeasure3,
                                                meas4: x.strMeasure4,
                                                meas5: x.strMeasure5,
                                                meas6: x.strMeasure6,
                                                meas7: x.strMeasure7,
                                                meas8: x.strMeasure8,
                                                meas9: x.strMeasure9,
                                                meas10: x.strMeasure10,
                                                meas11: x.strMeasure11,
                                                meas12: x.strMeasure12,
                                                meas13: x.strMeasure13,
                                                meas14: x.strMeasure14,
                                                meas15: x.strMeasure15,
                                                meas16: x.strMeasure16,
                                                meas17: x.strMeasure17,
                                                meas18: x.strMeasure18,
                                                meas19: x.strMeasure19,
                                                meas20: x.strMeasure20,
                                              ))));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              x.strMealThumb.toString()))),
                                  child: Stack(children: [
                                    Align(
                                      child: Container(
                                        padding: EdgeInsetsDirectional.all(10),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 70, horizontal: 1),
                                        height: 40,
                                        width: 200,
                                        color: Colors.black.withOpacity(0.4),
                                        child: Text(
                                          x.strMeal.toString(),
                                          selectionColor: Colors.white,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 1,
                                        right: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                      // Toggle the favorite status for the specific item
                                      favStatusMap[x.idMeal.toString()] =
                                          !getFavStatus(x.idMeal.toString());
                                    });
                                            _databasefavService
                                                .addfavStatus(
                                                  x.strMeal.toString(),
                                                  x.strArea.toString(),
                                                  x.strInstructions.toString(),
                                                  x.strMealThumb.toString(),
                                                  x.strCategory.toString(),
                                                  x.strIngredient1.toString(),
                                                  x.strIngredient2.toString(),
                                                  x.strIngredient3.toString(),
                                                  x.strIngredient4.toString(),
                                                  x.strIngredient5.toString(),
                                                  x.strIngredient6.toString(),
                                                  x.strIngredient7.toString(),
                                                  x.strIngredient8.toString(),
                                                  x.strIngredient9.toString(),
                                                  x.strIngredient10.toString(),
                                                  x.strIngredient11.toString(),
                                                  x.strIngredient12.toString(),
                                                  x.strIngredient13.toString(),
                                                  x.strIngredient14.toString(),
                                                  x.strIngredient15.toString(),
                                                  x.strIngredient16.toString(),
                                                  x.strIngredient17.toString(),
                                                  x.strIngredient18.toString(),
                                                  x.strIngredient19.toString(),
                                                  x.strIngredient20.toString(),
                                                  x.strMeasure1.toString(),
                                                  x.strMeasure2.toString(),
                                                  x.strMeasure3.toString(),
                                                  x.strMeasure4.toString(),
                                                  x.strMeasure5.toString(),
                                                  x.strMeasure6.toString(),
                                                  x.strMeasure7.toString(),
                                                  x.strMeasure8.toString(),
                                                  x.strMeasure9.toString(),
                                                  x.strMeasure10.toString(),
                                                  x.strMeasure11.toString(),
                                                  x.strMeasure12.toString(),
                                                  x.strMeasure13.toString(),
                                                  x.strMeasure14.toString(),
                                                  x.strMeasure15.toString(),
                                                  x.strMeasure16.toString(),
                                                  x.strMeasure17.toString(),
                                                  x.strMeasure18.toString(),
                                                  x.strMeasure19.toString(),
                                                  x.strMeasure20.toString(),
                                                )
                                                .then((value) {});
                                          },
                                          icon: Icon(Icons.favorite_border,
                                          ),
                                          color: getFavStatus(x.idMeal.toString())
                                      ? Colors.red
                                      : Colors.white,
                                          iconSize: 35, 
                                        ))
                                  ]),
                                ),
                              );
                            })
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromRGBO(250, 250, 250, 1.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => search()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fav()));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ))
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(154, 82, 26, 1.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addRecipe()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ), //BottomNavigationBAr
    ); //Scaffold
  }
}

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String? search;
  SearchPage({this.search});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseFavService _databasefavService = DatabaseFavService();
  final TextEditingController _searchController = TextEditingController();

  List<ModelSearch> list = <ModelSearch>[];
  String? text;

  getApiData(search) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=$search';

    var response = await http.get(Uri.parse(url));

    Map json = jsonDecode(response.body);

    json['meals'].forEach((e) {
      ModelSearch modelsearch = ModelSearch(
          idMeal: e['idMeal'],
          strMeal: e['strMeal'],
          strMealThumb: e['strMealThumb'],
          strArea: e['strArea'],
          strCategory: e['strCategory'],
          strInstructions: e['strInstructions'],
          strIngredient1: e['strIngredient1'],
          strIngredient2: e['strIngredient2'],
          strIngredient3: e['strIngredient3'],
          strIngredient4: e['strIngredient4'],
          strIngredient5: e['strIngredient5'],
          strIngredient6: e['strIngredient6'],
          strIngredient7: e['strIngredient7'],
          strIngredient8: e['strIngredient8'],
          strIngredient9: e['strIngredient9'],
          strIngredient10: e['strIngredient10'],
          strIngredient11: e['strIngredient11'],
          strIngredient12: e['strIngredient12'],
          strIngredient13: e['strIngredient13'],
          strIngredient14: e['strIngredient14'],
          strIngredient15: e['strIngredient15'],
          strIngredient16: e['strIngredient16'],
          strIngredient17: e['strIngredient17'],
          strIngredient18: e['strIngredient18'],
          strIngredient19: e['strIngredient19'],
          strIngredient20: e['strIngredient20'],
          strMeasure1: e['strMeasure1'],
          strMeasure2: e['strMeasure2'],
          strMeasure3: e['strMeasure3'],
          strMeasure4: e['strMeasure4'],
          strMeasure5: e['strMeasure5'],
          strMeasure6: e['strMeasure6'],
          strMeasure7: e['strMeasure7'],
          strMeasure8: e['strMeasure8'],
          strMeasure9: e['strMeasure9'],
          strMeasure10: e['strMeasure10'],
          strMeasure11: e['strMeasure11'],
          strMeasure12: e['strMeasure12'],
          strMeasure13: e['strMeasure13'],
          strMeasure14: e['strMeasure14'],
          strMeasure15: e['strMeasure15'],
          strMeasure16: e['strMeasure16'],
          strMeasure17: e['strMeasure17'],
          strMeasure18: e['strMeasure18'],
          strMeasure19: e['strMeasure19'],
          strMeasure20: e['strMeasure20']);
      setState(() {
        list.add(modelsearch);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(85),
              child: Text(
                "Arama",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // Add padding around the search bar
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),

                // Use a Material design search bar
                child: TextField(
                  onChanged: (v) {
                    text = v;
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      iconColor: Color.fromRGBO(0, 0, 0, 1),
                      hintText: 'Arama...',
                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                        color: Color.fromRGBO(154, 82, 26, 1),
                      ),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage(
                                        search: text,
                                      )));
                        },
                        color: Color.fromRGBO(154, 82, 26, 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(154, 82, 26, 1)),
                          borderRadius: BorderRadius.circular(30))),
                  onEditingComplete: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                  search: text,
                                )));
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: list.length,
                          itemBuilder: (context, i) {
                            final x = list[i];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => DetailPage(
                                              img: x.strMealThumb,
                                              header: x.strMeal,
                                              area: x.strArea,
                                              category: x.strCategory,
                                              ins: x.strInstructions,
                                              ing1: x.strIngredient1,
                                              ing2: x.strIngredient2,
                                              ing3: x.strIngredient3,
                                              ing4: x.strIngredient4,
                                              ing5: x.strIngredient5,
                                              ing6: x.strIngredient6,
                                              ing7: x.strIngredient7,
                                              ing8: x.strIngredient8,
                                              ing9: x.strIngredient9,
                                              ing10: x.strIngredient10,
                                              ing11: x.strIngredient11,
                                              ing12: x.strIngredient12,
                                              ing13: x.strIngredient13,
                                              ing14: x.strIngredient14,
                                              ing15: x.strIngredient15,
                                              ing16: x.strIngredient16,
                                              ing17: x.strIngredient17,
                                              ing18: x.strIngredient18,
                                              ing19: x.strIngredient19,
                                              ing20: x.strIngredient20,
                                              meas1: x.strMeasure1,
                                              meas2: x.strMeasure2,
                                              meas3: x.strMeasure3,
                                              meas4: x.strMeasure4,
                                              meas5: x.strMeasure5,
                                              meas6: x.strMeasure6,
                                              meas7: x.strMeasure7,
                                              meas8: x.strMeasure8,
                                              meas9: x.strMeasure9,
                                              meas10: x.strMeasure10,
                                              meas11: x.strMeasure11,
                                              meas12: x.strMeasure12,
                                              meas13: x.strMeasure13,
                                              meas14: x.strMeasure14,
                                              meas15: x.strMeasure15,
                                              meas16: x.strMeasure16,
                                              meas17: x.strMeasure17,
                                              meas18: x.strMeasure18,
                                              meas19: x.strMeasure19,
                                              meas20: x.strMeasure20,
                                            ))));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            x.strMealThumb.toString()))),
                                child: Stack(children: [
                                  Align(
                                    child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 70, horizontal: 1),
                                      height: 40,
                                      width: 200,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Text(
                                        x.strMeal.toString(),
                                        selectionColor: Colors.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: IconButton(
                                        onPressed: () {
                                          _databasefavService
                                              .addfavStatus(
                                                x.strMeal.toString(),
                                                x.strArea.toString(),
                                                x.strInstructions.toString(),
                                                x.strMealThumb.toString(),
                                                x.strCategory.toString(),
                                                x.strIngredient1.toString(),
                                                x.strIngredient2.toString(),
                                                x.strIngredient3.toString(),
                                                x.strIngredient4.toString(),
                                                x.strIngredient5.toString(),
                                                x.strIngredient6.toString(),
                                                x.strIngredient7.toString(),
                                                x.strIngredient8.toString(),
                                                x.strIngredient9.toString(),
                                                x.strIngredient10.toString(),
                                                x.strIngredient11.toString(),
                                                x.strIngredient12.toString(),
                                                x.strIngredient13.toString(),
                                                x.strIngredient14.toString(),
                                                x.strIngredient15.toString(),
                                                x.strIngredient16.toString(),
                                                x.strIngredient17.toString(),
                                                x.strIngredient18.toString(),
                                                x.strIngredient19.toString(),
                                                x.strIngredient20.toString(),
                                                x.strMeasure1.toString(),
                                                x.strMeasure2.toString(),
                                                x.strMeasure3.toString(),
                                                x.strMeasure4.toString(),
                                                x.strMeasure5.toString(),
                                                x.strMeasure6.toString(),
                                                x.strMeasure7.toString(),
                                                x.strMeasure8.toString(),
                                                x.strMeasure9.toString(),
                                                x.strMeasure10.toString(),
                                                x.strMeasure11.toString(),
                                                x.strMeasure12.toString(),
                                                x.strMeasure13.toString(),
                                                x.strMeasure14.toString(),
                                                x.strMeasure15.toString(),
                                                x.strMeasure16.toString(),
                                                x.strMeasure17.toString(),
                                                x.strMeasure18.toString(),
                                                x.strMeasure19.toString(),
                                                x.strMeasure20.toString(),
                                              )
                                              .then((value) {});
                                        },
                                        icon: Icon(Icons.favorite_border),
                                        color: Colors.white,
                                        iconSize: 35,
                                      ))
                                ]),
                              ),
                            );
                          })
                    ]),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromRGBO(250, 250, 250, 1.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => search()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fav()));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ))
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(154, 82, 26, 1.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addRecipe()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),

      //BottomNavigationBAr
    ); //Scaffold
  }
}

class DetailPage extends StatelessWidget {
  final header,
      ins,
      area,
      category,
      img,
      ing1,
      ing2,
      ing3,
      ing4,
      ing5,
      ing6,
      ing7,
      ing8,
      ing9,
      ing10,
      ing11,
      ing12,
      ing13,
      ing14,
      ing15,
      ing16,
      ing17,
      ing18,
      ing19,
      ing20,
      meas1,
      meas2,
      meas3,
      meas4,
      meas5,
      meas6,
      meas7,
      meas8,
      meas9,
      meas10,
      meas11,
      meas12,
      meas13,
      meas14,
      meas15,
      meas16,
      meas17,
      meas18,
      meas19,
      meas20;
  DetailPage(
      {this.header,
      this.area,
      this.category,
      this.ins,
      this.img,
      this.ing1,
      this.ing2,
      this.ing3,
      this.ing4,
      this.ing5,
      this.ing6,
      this.ing7,
      this.ing8,
      this.ing9,
      this.ing10,
      this.ing11,
      this.ing12,
      this.ing13,
      this.ing14,
      this.ing15,
      this.ing16,
      this.ing17,
      this.ing18,
      this.ing19,
      this.ing20,
      this.meas1,
      this.meas2,
      this.meas3,
      this.meas4,
      this.meas5,
      this.meas6,
      this.meas7,
      this.meas8,
      this.meas9,
      this.meas10,
      this.meas11,
      this.meas12,
      this.meas13,
      this.meas14,
      this.meas15,
      this.meas16,
      this.meas17,
      this.meas18,
      this.meas19,
      this.meas20});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(85),
              child: Text(
                "Details",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: w,
                  height: h * .4,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(img.toString()))),
                ),
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    header.toString() +
                        "\n\n" +
                        area.toString() +
                        "    " +
                        category.toString(),
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 350,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "~Malzemeler~",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 350,
                      child: Text(
                        meas1.toString() +
                            "   " +
                            ing1.toString() +
                            "\n" +
                            meas2.toString() +
                            "   " +
                            ing2.toString() +
                            "\n" +
                            meas3.toString() +
                            "   " +
                            ing3.toString() +
                            "\n" +
                            meas4.toString() +
                            "   " +
                            ing4.toString() +
                            "\n" +
                            meas5.toString() +
                            "   " +
                            ing5.toString() +
                            "\n" +
                            meas6.toString() +
                            "   " +
                            ing6.toString() +
                            "\n" +
                            meas7.toString() +
                            "   " +
                            ing7.toString() +
                            "\n" +
                            meas8.toString() +
                            "   " +
                            ing8.toString() +
                            "\n" +
                            meas9.toString() +
                            "   " +
                            ing9.toString() +
                            "\n" +
                            meas10.toString() +
                            "   " +
                            ing10.toString() +
                            "\n" +
                            meas11.toString() +
                            "   " +
                            ing11.toString() +
                            "\n" +
                            meas12.toString() +
                            "   " +
                            ing12.toString() +
                            "\n" +
                            meas13.toString() +
                            "   " +
                            ing13.toString() +
                            "\n" +
                            meas14.toString() +
                            "   " +
                            ing14.toString() +
                            "\n" +
                            meas15.toString() +
                            "   " +
                            ing15.toString() +
                            "\n" +
                            meas16.toString() +
                            "   " +
                            ing16.toString() +
                            "\n" +
                            meas17.toString() +
                            "   " +
                            ing17.toString() +
                            "\n" +
                            meas18.toString() +
                            "   " +
                            ing18.toString() +
                            "\n" +
                            meas19.toString() +
                            "   " +
                            ing19.toString() +
                            "\n" +
                            meas20.toString() +
                            "   " +
                            ing20.toString(),
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "~Yapılışı~",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 350,
                    child: Text(
                      ins.toString(),
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromRGBO(250, 250, 250, 1.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => search()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fav()));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ))
            ],
          )),
    );
  }
}
