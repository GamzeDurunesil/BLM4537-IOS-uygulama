import 'dart:convert';
import 'package:flutter_application_1/database/dbforfavorite.dart';
import 'package:flutter_application_1/firstpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/pages/add_recipe.dart';
import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseAuth = FirebaseAuth.instance;
  List<Model> list = <Model>[];
  final url = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['categories'].forEach((e) {
      Model model = Model(
        strCategory: e['strCategory'],
        strCategoryThumb: e['strCategoryThumb'],
        idCategory: e['idCategory'],
      );
      setState(() {
        list.add(model);
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
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(65),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
                height: 115,
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                                          builder: ((context) => Categoryin(
                                                search: x.strCategory,
                                              ))));
                                },
                                child: SingleChildScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(200, 200, 200, 1),
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(x
                                                .strCategoryThumb
                                                .toString()))),
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsetsDirectional.all(10),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 70, horizontal: 1),
                                        height: 40,
                                        width: 200,
                                        color: Colors.black.withOpacity(0.4),
                                        child: Text(
                                          x.strCategory.toString(),
                                          selectionColor: Colors.white,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            })
                      ]),
                ),
              ),
            ),
          ],
        ),
      ), //AppBars

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
class Categoryin extends StatefulWidget {
  String? search;
  Categoryin({this.search});
  @override
  _CategoryinState createState() => _CategoryinState();
}

class _CategoryinState extends State<Categoryin> {
  List<ModelSearch> list = <ModelSearch>[];
  String? text;

  getApiData(search) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$search';
    text = search;
    var response = await http.get(Uri.parse(url));

    Map json = jsonDecode(response.body);

    json['meals'].forEach((e) {
      ModelSearch modelsearch = ModelSearch(
          idMeal: e['idMeal'],
          strMeal: e['strMeal'],
          strArea: e['strArea'],
          strCategory: e['strCategory'],
          strMealThumb: e['strMealThumb'],
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
        }
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
                text.toString(),
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
                                        builder: ((context) => CatSearchPage(
                                              catsearch: x.strMeal,
                                            ))));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          x.strMealThumb.toString())),
                                ),
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

// ignore: must_be_immutable
class CatSearchPage extends StatefulWidget {
  String? catsearch;
  CatSearchPage({this.catsearch});
  @override
  _CatSearchPageState createState() => _CatSearchPageState();
}

class _CatSearchPageState extends State<CatSearchPage> {
  Map<String, bool> favStatusMap = {};
  bool getFavStatus(String idMeal) {
    return favStatusMap[idMeal] ?? false;
  }

  DatabaseFavService _databasefavService = DatabaseFavService();

  List<ModelSearch> list = <ModelSearch>[];
  String? text;

  getApiData(catsearch) async {
    final url =
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$catsearch';
    text = catsearch;
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
        favStatusMap[modelsearch.idMeal.toString()] = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getApiData(widget.catsearch);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        text.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(154, 82, 26, 1),
                            fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];

                    return InkWell(
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(children: [
                              Container(
                                width: w,
                                height: h * .4,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            x.strMealThumb.toString()))),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(w * .8, 0, 0, 0),
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
                                    icon: Icon(Icons.favorite_border),
                                    color: getFavStatus(x.idMeal.toString())
                                        ? Colors.red
                                        : Colors.white,
                                    iconSize: 35,
                                  )),
                              Container(
                                width: 300,
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  x.strMeal.toString() +
                                      "\n\n" +
                                      x.strArea.toString() +
                                      "     " +
                                      x.strCategory.toString(),
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
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
                                height: 40,
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
                                    width: 370,
                                    child: Text(
                                      x.strMeasure1.toString() +
                                          "   " +
                                          x.strIngredient1.toString() +
                                          "\n" +
                                          x.strMeasure2.toString() +
                                          "   " +
                                          x.strIngredient2.toString() +
                                          "\n" +
                                          x.strMeasure3.toString() +
                                          "   " +
                                          x.strIngredient3.toString() +
                                          "\n" +
                                          x.strMeasure4.toString() +
                                          "   " +
                                          x.strIngredient4.toString() +
                                          "\n" +
                                          x.strMeasure5.toString() +
                                          "   " +
                                          x.strIngredient5.toString() +
                                          "\n" +
                                          x.strMeasure6.toString() +
                                          "   " +
                                          x.strIngredient6.toString() +
                                          "\n" +
                                          x.strMeasure7.toString() +
                                          "   " +
                                          x.strIngredient7.toString() +
                                          "\n" +
                                          x.strMeasure8.toString() +
                                          "   " +
                                          x.strIngredient8.toString() +
                                          "\n" +
                                          x.strMeasure9.toString() +
                                          "   " +
                                          x.strIngredient9.toString() +
                                          "\n" +
                                          x.strMeasure10.toString() +
                                          "   " +
                                          x.strIngredient10.toString() +
                                          "\n" +
                                          x.strMeasure11.toString() +
                                          "   " +
                                          x.strIngredient11.toString() +
                                          "\n" +
                                          x.strMeasure12.toString() +
                                          "   " +
                                          x.strIngredient12.toString() +
                                          "\n" +
                                          x.strMeasure13.toString() +
                                          "   " +
                                          x.strIngredient13.toString() +
                                          "\n" +
                                          x.strMeasure14.toString() +
                                          "   " +
                                          x.strIngredient14.toString() +
                                          "\n" +
                                          x.strMeasure15.toString() +
                                          "   " +
                                          x.strIngredient15.toString() +
                                          "\n" +
                                          x.strMeasure16.toString() +
                                          "   " +
                                          x.strIngredient16.toString() +
                                          "\n" +
                                          x.strMeasure17.toString() +
                                          "   " +
                                          x.strIngredient17.toString() +
                                          "\n" +
                                          x.strMeasure18.toString() +
                                          "   " +
                                          x.strIngredient18.toString() +
                                          "\n" +
                                          x.strMeasure19.toString() +
                                          "   " +
                                          x.strIngredient19.toString() +
                                          "\n" +
                                          x.strMeasure20.toString() +
                                          "   " +
                                          x.strIngredient20.toString(),
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
                                  width: 370,
                                  child: Text(
                                    x.strInstructions.toString(),
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  }),
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

      //BottomNavigationBAr
    ); //Scaffold
  }
}
