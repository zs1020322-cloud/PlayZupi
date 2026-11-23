
import 'package:flutter/material.dart';

void main() {
  runApp(const PlayZupiApp());
}

class PlayZupiApp extends StatelessWidget {
  const PlayZupiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayZupi',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100D20),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final Color purple = const Color(0xFF7028F5);
  final Color violet = const Color(0xFFA43BFF);
  final Color gold = const Color(0xFFFFC83D);

  final List<String> titles = [
    'Home',
    'Room',
    'Game',
    'Wallet',
    'Friend',
    'Profile',
  ];

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.mic_rounded,
    Icons.games_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.people_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF100D20),
        title: Text(
          'PlayZupi',
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons[selectedIndex],
              size: 80,
              color: violet,
            ),
            const SizedBox(height: 20),
            Text(
              titles[selectedIndex],
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: gold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to PlayZupi',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF19132B),
        indicatorColor: purple.withValues(alpha: 0.35),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: List.generate(6, (index) {
          return NavigationDestination(
            icon: Icon(icons[index]),
            label: titles[index],
          );
        }),
      ),
    );
  }
}
