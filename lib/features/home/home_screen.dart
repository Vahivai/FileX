import 'package:flutter/material.dart';

import 'widgets/header_widget.dart';
import 'widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Grid
    final double width = MediaQuery.of(context).size.width;

    int crossAxisCount;

    if (width < 700) {
      crossAxisCount = 2; // Mobile
    } else if (width < 1200) {
      crossAxisCount = 3; // Tablet / Small Desktop
    } else {
      crossAxisCount = 4; // Large Desktop
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "FileX",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: [
                HomeCard(
                  icon: Icons.upload_file,
                  title: "Send Files",
                  onTap: () {},
                ),
                HomeCard(
                  icon: Icons.download,
                  title: "Receive Files",
                  onTap: () {},
                ),
                HomeCard(
                  icon: Icons.devices,
                  title: "Nearby",
                  onTap: () {},
                ),
                HomeCard(
                  icon: Icons.public,
                  title: "Online",
                  onTap: () {},
                ),
                HomeCard(
                  icon: Icons.history,
                  title: "History",
                  onTap: () {},
                ),
                HomeCard(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Transfers",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "No transfers yet",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}