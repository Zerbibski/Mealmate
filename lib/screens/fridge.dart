import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_mate/services/streams.dart';
import 'package:meal_mate/utils/colors.dart';
import 'package:meal_mate/utils/styles.dart';
import 'package:meal_mate/widgets/back_button.dart';

class Fridge extends StatefulWidget {
  const Fridge({super.key});

  @override
  State<Fridge> createState() => _FridgeState();
}

class _FridgeState extends State<Fridge> {
  bool isMeat = false;
  bool isVegetables = false;
  bool isFruits = false;
  bool isOils = false;
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
          'Fridge',
          style: normalBoldWhiteStyle.copyWith(
              fontFamily: 'Omnes', fontSize: 20.sp),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'In my fridge there is...',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: white,
                        fontFamily: 'Omnes'),
                  ),
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
                      hintText: 'Search for products name',
                      hintStyle: TextStyle(color: black),
                    ),
                  ),
                ),
                Gap(15.h),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: const Text('Meat'),
                        selected: isMeat,
                        onSelected: (bool selected) {
                          setState(() {
                            isMeat = selected;
                            isVegetables = false;
                            isFruits = false;
                            isOils = false;
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 255, 180, 68),
                      ),
                      FilterChip(
                        label: const Text('Vegetables'),
                        selected: isVegetables,
                        onSelected: (bool selected) {
                          setState(() {
                            isVegetables = selected;
                            isMeat = false;
                            isFruits = false;
                            isOils = false;
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 255, 180, 68),
                      ),
                      FilterChip(
                        label: const Text('Fruits'),
                        selected: isFruits,
                        onSelected: (bool selected) {
                          setState(() {
                            isFruits = selected;
                            isMeat = false;
                            isVegetables = false;
                            isOils = false;
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 255, 180, 68),
                      ),
                      FilterChip(
                        label: const Text('Oils'),
                        selected: isOils,
                        onSelected: (bool selected) {
                          setState(() {
                            isOils = selected;
                            isMeat = false;
                            isVegetables = false;
                            isFruits = false;
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 255, 180, 68),
                      ),
                    ],
                  ),
                ),
                FridgeList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FridgeList extends StatelessWidget {
  final DataStreams _ds = DataStreams();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  FridgeList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _ds.fridge,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No recipes found'));
        }

        var fridgeItems = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          itemCount: fridgeItems.length,
          itemBuilder: (context, index) {
            var item = fridgeItems[index];
            return FridgeItemCard(
              title: item['title'],
              subtitle: item['subtitle'],
              unity: item['unity'],
            );
          },
        );
      },
    );
  }
}

class FridgeItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String unity;

  const FridgeItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.unity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Column(
              children: [
                Icon(Icons.add_circle, color: Colors.green, size: 30),
                SizedBox(height: 8),
                Icon(Icons.remove_circle, color: Colors.red, size: 30),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Omnes',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      unity,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: black,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
