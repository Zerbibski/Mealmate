import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:meal_mate/services/streams.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/widgets/back_button.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  bool isBeef = false;
  bool isCarrot = false;
  bool isPotato = false;
  bool isTomato = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: const MeatMateBackButton(
          iconColor: white,
          color: transparent,
        ),
        title: Text(
          'Receipes',
          style: normalBoldWhiteStyle.copyWith(
              fontFamily: 'Omnes', fontSize: 20.sp),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'I want to cook...',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontFamily: 'Omnes'),
                ),
                Gap(20.h),
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    style: normalBoldWhiteStyle.copyWith(color: black),
                    cursorColor: black,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: black),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: black),
                    ),
                  ),
                ),
                Gap(20.h),
                Wrap(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                      label: const Text('Beef'),
                      selected: isBeef,
                      onSelected: (bool selected) {
                        setState(() {
                          isBeef = selected;
                          isCarrot = false;
                          isPotato = false;
                          isTomato = false;
                        });
                      },
                      selectedColor: const Color.fromARGB(255, 255, 180, 68),
                    ),
                    FilterChip(
                      label: const Text('Carrot'),
                      selected: isCarrot,
                      onSelected: (bool selected) {
                        setState(() {
                          isCarrot = selected;
                          isBeef = false;
                          isPotato = false;
                          isTomato = false;
                        });
                      },
                      selectedColor: const Color.fromARGB(255, 255, 180, 68),
                    ),
                    FilterChip(
                      label: const Text('Potato'),
                      selected: isPotato,
                      onSelected: (bool selected) {
                        setState(() {
                          isPotato = selected;
                          isBeef = false;
                          isCarrot = false;
                          isTomato = false;
                        });
                      },
                      selectedColor: const Color.fromARGB(255, 255, 180, 68),
                    ),
                    FilterChip(
                      label: const Text('Tomato'),
                      selected: isTomato,
                      onSelected: (bool selected) {
                        setState(() {
                          isTomato = selected;
                          isBeef = false;
                          isCarrot = false;
                          isPotato = false;
                        });
                      },
                      selectedColor: const Color.fromARGB(255, 255, 180, 68),
                    ),
                  ],
                ),
                Gap(20.h),
                const Text(
                  'Recipes with the selected ingredients and what you have in your fridge',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: white,
                      fontFamily: 'Omnes'),
                ),
                Gap(20.h),
                RecipeList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final DataStreams _ds = DataStreams();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _ds.receipes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No recipes found'));
        }

        var recipes = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            var recipe = recipes[index];
            int grade = recipe['grade'] ?? 0;

            return Card(
              elevation: 10,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: recipe['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          recipe['image'] ?? "",
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      )
                    : Container(width: 60, height: 60, color: Colors.grey),
                title: Text(recipe['title'] ?? ""),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe['subtitle'] ?? ""),
                    Text('Total Time: ${recipe['time'] ?? ""} mins'),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                              grade,
                              (index) => const Icon(Icons.star,
                                  color: Colors.orange, size: 16)),
                        ),
                        const SizedBox(
                            width: 4), // Add spacing between stars and text
                        Text('(${recipe['review'] ?? ""} Reviews)'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
