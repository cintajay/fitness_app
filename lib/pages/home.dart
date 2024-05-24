import 'package:fitness_app/models/category_model.dart';
import 'package:fitness_app/models/diet_model.dart';
import 'package:fitness_app/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  void initState() {
    super.initState();
    getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          _searchField(),
          _categoriesText(), //if no comma, use comma and add on
          _categories(),
          const SizedBox(
            height: 20,
          ),
          _headerRecForDiet(),
          _dietSection(),
          const SizedBox(
            height: 20,
          ),
          _popularText(),
          _popularSection(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  ListView _popularSection() {
    return ListView.separated(
          shrinkWrap: true, //this allows listView to scroll beyond view
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: popularDiets[index].boxIsSelected ?
                Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: popularDiets[index].boxIsSelected ? [
                  BoxShadow( //adding boxShadow when boxIsSelected is true
                    color: const Color(0xff1D1617).withOpacity(0.07),
                    offset: const Offset(0, 10),
                    blurRadius: 40,
                    spreadRadius: 0
                  )
                ] : []
              ),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      popularDiets[index].iconPath,
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        popularDiets[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      Text(
                        popularDiets[index].level +'|'+popularDiets[index].duration +'|'+popularDiets[index].calorie,
                        style: TextStyle(
                          color:  Color(0xff7B6F72)
                        )
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                        'assets/button.svg',
                        //width: 65,
                        //height: 65,
                    ),
                  )
                ],
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20,
            );
          }, 
          itemCount: popularDiets.length,
          padding: EdgeInsets.all(20),
        );
  }

  Padding _popularText() {
    return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Popular',
            style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
          ),
        );
  }

  Container _dietSection() {
    return Container(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
               width: 200,
               decoration: BoxDecoration(
                color: diets[index].boxColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20)                    
               ), 
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: SvgPicture.asset(diets[index].iconPath),
                  ),
                  Column(       //added a seperate column for the 2 texts to bring them closer
                    children: [
                      Text(
                        diets[index].name, 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        )
                      ),
                      Text(
                        diets[index].level +'|'+diets[index].duration +'|'+diets[index].calorie,
                        style: TextStyle(
                          color:  Color(0xff7B6F72)
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          diets[index].viewIsSelected ? Color(0xff9DCEFF): Colors.transparent,
                          diets[index].viewIsSelected ? Color(0xff92A3FD): Colors.transparent,
                        ]
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: diets[index].viewIsSelected ? Colors.white : Color(0xffC58BF2)
                      ),
                    ),
                  )
                ],
               )
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(width: 20), 
            itemCount: diets.length
          ),
        );
  }

  Container _headerRecForDiet() {
    return Container(
          padding: EdgeInsets.all(20),
          child: const Text(
            "Recommendation \nfor Diet",
            style: 
            TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
          ),
        );
  }

  Column _categoriesText() {
    return const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                textAlign: TextAlign.left,
                
              ),
            ),
          ],
        );
  }

  Container _categories() {
    return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20
          ),
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20), //=> or use return stmt
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)                    
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: SvgPicture.asset(categories[index].iconPath),
                      alignment: Alignment.center,
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    )
                  ],
                )
              );
            }
          ),
        );
  }

  Container _searchField() {
    return Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset('assets/Search.svg'),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset('assets/Filter.svg'),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)
              ),
              hintText: "Search Pancakes",
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xffDDDADA)
              )
            ),
          ),
        );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        "Breakfast",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black
        )
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/Arrow - Left 2.svg'),
        ),
      centerTitle: true,
      actions: [
        Container(
        margin: const EdgeInsets.all(8),
        width: 37,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/dots.svg'),
        )
      ],
    );
  }
}