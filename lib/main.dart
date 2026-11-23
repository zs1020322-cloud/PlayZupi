
import 'package:flutter/material.dart';

void main() {
  runApp(const PlayZupiApp());
}

const Color black = Color(0xFF111111);
const Color gold = Color(0xFFFFC83D);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFFE8E8E8);

class PlayZupiApp extends StatelessWidget {
  const PlayZupiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayZupi',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: white,
        fontFamily: 'Roboto',
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

  final List<String> tabNames = [
    'Home',
    'Room',
    'Game',
    'Wallet',
    'Friend',
    'Profile',
  ];

  final List<IconData> tabIcons = [
    Icons.home_rounded,
    Icons.mic_rounded,
    Icons.sports_esports_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.people_alt_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              white,
              Color(0xFFF7F7F7),
              Color(0xFFE1E1E1),
            ],
          ),
        ),
        child: SafeArea(
          child: selectedIndex == 0
              ? const HomeScreen()
              : selectedIndex == 5
                  ? const ProfileScreen()
                  : OtherTabScreen(
                      title: tabNames[selectedIndex],
                      icon: tabIcons[selectedIndex],
                    ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [white, Color(0xFFE4E4E4)],
        ),
        border: const Border(
          top: BorderSide(color: Color(0xFFBDBDBD), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
          child: Row(
            children: List.generate(6, (index) {
              final bool active = selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      gradient: active
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFFE49A),
                                gold,
                                Color(0xFFE7A900),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: active ? null : white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: active ? black : const Color(0xFFCCCCCC),
                        width: active ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.13),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tabIcons[index],
                          size: 23,
                          color: black,
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            tabNames[index],
                            style: const TextStyle(
                              color: black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 25),
      child: Column(
        children: [
          Row(
            children: [
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
                          fontSize: 35,
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
                  ),
                  const Positioned(
                    top: -8,
                    child: Icon(
                      Icons.workspace_premium,
                      color: gold,
                      size: 42,
                    ),
                  ),
                  Positioned(
                    bottom: -6,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      color: gold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [white, grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: gold, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Settings coming soon'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: black,
                    size: 29,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const WelcomeCard(),
          const SizedBox(height: 28),
          const DailyOption(
            title: 'Daily Reward',
            icon: Icons.card_giftcard_rounded,
          ),
          const DailyOption(
            title: 'Daily Event',
            icon: Icons.calendar_month_rounded,
          ),
          const DailyOption(
            title: 'Daily Update',
            icon: Icons.update_rounded,
          ),
          const DailyOption(
            title: 'New Reward',
            icon: Icons.diamond_rounded,
          ),
          const DailyOption(
            title: 'Daily Task',
            icon: Icons.task_alt_rounded,
          ),
          const DailyOption(
            title: 'New Update',
            icon: Icons.campaign_rounded,
          ),
        ],
      ),
    );
  }
}

// PROFILE SCREEN

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // EDIT PROFILE

          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Edit Profile coming soon'),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_rounded,
                size: 17,
                color: black,
              ),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: gold, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 10,
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // DP, USERNAME AND ID

          Row(
            children: [
              Container(
                width: 94,
                height: 94,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [white, grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: gold,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.20),
                      blurRadius: 9,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 57,
                  color: black,
                ),
              ),

              const SizedBox(width: 18),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: black,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'ID: 12345678',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // FOLLOWERS, FOLLOWING, VISITORS AND GIFT

          Row(
            children: const [
              ProfileStat(
                title: 'Followers',
                count: '0',
              ),
              ProfileStatDivider(),
              ProfileStat(
                title: 'Following',
                count: '0',
              ),
              ProfileStatDivider(),
              ProfileStat(
                title: 'Visitors',
                count: '0',
              ),
              ProfileStatDivider(),
              ProfileStat(
                title: 'Gift',
                count: '0',
              ),
            ],
          ),

          const SizedBox(height: 13),

          // ONE LIGHT HORIZONTAL LINE

          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFFCCCCCC),
          ),

          // Neeche ka Profile section baad mein banayenge.
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final String count;

  const ProfileStat({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: const TextStyle(
                color: black,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            count,
            style: const TextStyle(
              color: Color(0xFF777777),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStatDivider extends StatelessWidget {
  const ProfileStatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 31,
      color: const Color(0xFFD0D0D0),
    );
  }
}

// WELCOME CARD

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF393939),
            Color(0xFF171717),
            Color(0xFF050505),
          ],
        ),
        border: Border.all(color: gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.45),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -25,
            top: -25,
            child: Icon(
              Icons.workspace_premium,
              size: 190,
              color: gold.withOpacity(0.09),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 23, 8, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 39,
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
                const SizedBox(height: 12),
                const Text(
                  'Play Together\nConnect Forever',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 95,
                  height: 3,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 8,
            top: 35,
            child: Column(
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: gold,
                  size: 60,
                ),
                SizedBox(height: 5),
                Icon(
                  Icons.sports_esports_rounded,
                  color: gold,
                  size: 85,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DAILY OPTION BOXES

class DailyOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const DailyOption({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            white,
            Color(0xFFFDFDFD),
            Color(0xFFE5E5E5),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.40),
            blurRadius: 17,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: white.withOpacity(0.9),
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title coming soon'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFE9A8),
                        gold,
                        Color(0xFFD99A00),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC18B00),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.20),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: black,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 19),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: black,
                  size: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// OTHER TABS

class OtherTabScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const OtherTabScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [white, grey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.30),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: black,
              size: 55,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: black,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
