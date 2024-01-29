import 'package:fitness_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];

  getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    getCategories();
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          searchField(),
          const Column(
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
          ), //if no comma, use comma and add on
          Container(
            height: 150,
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
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: SvgPicture.asset(categories[index].iconPath),
                      )
                    ],
                  )
                );
              }
            ),
          )
        ],
      ),
    );
  }

  Container searchField() {
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

  AppBar appBar() {
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