
import 'package:flutter/material.dart';

void main() {
  runApp(const PlayZupiApp());
}

const Color black = Color(0xFF050505);
const Color white = Color(0xFFFFFFFF);
const Color gold = Color(0xFFFFC629);
const Color darkGold = Color(0xFFB77A00);

class PlayZupiApp extends StatelessWidget {
  const PlayZupiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayZupi',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: darkGold,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 25),
          child: Column(
            children: [
              // TOP HEADER
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [gold, darkGold, gold],
                      ),
                      border: Border.all(color: gold, width: 3),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 43,
                        color: black,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 37,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              letterSpacing: -2,
                            ),
                            children: [
                              TextSpan(
                                text: 'Play',
                                style: TextStyle(color: white),
                              ),
                              TextSpan(
                                text: 'Zupi',
                                style: TextStyle(color: gold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -9,
                        child: Icon(
                          Icons.workspace_premium,
                          color: gold,
                          size: 43,
                        ),
                      ),
                      Positioned(
                        bottom: -7,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 3,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [darkGold, gold, white, gold],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  InkWell(
                    onTap: () => showMessage(
                      context,
                      'Settings coming soon',
                    ),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: black,
                        border: Border.all(color: gold, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: gold.withOpacity(0.35),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: gold,
                        size: 34,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // WELCOME CARD
              Container(
                height: 225,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: gold, width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withOpacity(0.35),
                      blurRadius: 13,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned(
                      right: -25,
                      top: 0,
                      bottom: 0,
                      width: 175,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF17120A), black],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 20, 8, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome to',
                            style: TextStyle(
                              color: black,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 39,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                letterSpacing: -2,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Play',
                                  style: TextStyle(color: black),
                                ),
                                TextSpan(
                                  text: 'Zupi',
                                  style: TextStyle(color: gold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Play Together\nConnect Forever',
                            style: TextStyle(
                              color: black,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 35,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.workspace_premium,
                            color: gold,
                            size: 65,
                          ),
                          const Icon(
                            Icons.sports_esports,
                            color: gold,
                            size: 100,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? gold : black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // SIX LONG MENU BOXES
              const MenuItem(
                title: 'Daily Reward',
                icon: Icons.card_giftcard,
              ),
              const MenuItem(
                title: 'Daily Event',
                icon: Icons.calendar_month,
              ),
              const MenuItem(
                title: 'Daily Update',
                icon: Icons.sync,
              ),
              const MenuItem(
                title: 'New Update',
                icon: Icons.notifications_active,
              ),
              const MenuItem(
                title: 'New Reward',
                icon: Icons.diamond,
              ),
              const MenuItem(
                title: 'Daily Task',
                icon: Icons.task_alt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: gold, width: 5),
        boxShadow: [
          BoxShadow(
            color: gold.withOpacity(0.25),
            blurRadius: 9,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title coming soon'),
                backgroundColor: darkGold,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 43,
                  color: black,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: black,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: gold,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
