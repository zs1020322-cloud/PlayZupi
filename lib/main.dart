
import 'package:flutter/material.dart';

void main() {
  runApp(const PlayZupiApp());
}

const Color black = Color(0xFF111111);
const Color gold = Color(0xFFFFC83D);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFFE8E8E8);

// APP

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

// MAIN SCREEN

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    'Home', 'Room', 'Game', 'Wallet', 'Friend', 'Profile',
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
            colors: [white, Color(0xFFF7F7F7), Color(0xFFE1E1E1)],
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
                    setState(() => selectedIndex = index);
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
                        Icon(tabIcons[index], size: 23, color: black),
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
                    child: Container(height: 3, color: gold),
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

// COMMON BOX DESIGN

BoxDecoration profileBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [white, Color(0xFFFDFDFD), Color(0xFFE5E5E5)],
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
  );
}

// PROFILE SCREEN

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
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
          const SizedBox(height: 18),

          // DP, USERNAME AND ID

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: profileBoxDecoration(),
            child: Row(
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [white, grey],
                    ),
                    border: Border.all(color: gold, width: 2.5),
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
          ),

          const SizedBox(height: 28),

          // FOUR STATISTICS

          Row(
            children: const [
              ProfileStat(title: 'Followers', count: '0'),
              ProfileStatDivider(),
              ProfileStat(title: 'Following', count: '0'),
              ProfileStatDivider(),
              ProfileStat(title: 'Visitors', count: '0'),
              ProfileStatDivider(),
              ProfileStat(title: 'Gift', count: '0'),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFFCCCCCC),
          ),
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

// EDIT PROFILE PAGE

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? selectedGender;
  String? selectedCountry;
  DateTime? selectedDate;

  final List<String> countries = [
    'United Arab Emirates',
    'Pakistan',
    'India',
    'Saudi Arabia',
    'Bangladesh',
    'Afghanistan',
    'Nepal',
    'Sri Lanka',
    'United Kingdom',
    'United States',
    'Qatar',
    'Oman',
    'Kuwait',
    'Turkey',
    'Canada',
  ];

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [white, Color(0xFFF7F7F7), Color(0xFFE1E1E1)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 15, 18, 30),
          child: Column(
            children: [
              // CHANGE DP

              EditProfileOption(
                title: 'Change DP',
                icon: Icons.camera_alt_rounded,
                onTap: () => showComingSoon('Change DP'),
              ),

              // CHANGE NAME

              ProfileInputBox(
                title: 'Change Name',
                icon: Icons.person_rounded,
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF999999)),
                  ),
                ),
              ),

              // BIO

              ProfileInputBox(
                title: 'Bio',
                icon: Icons.description_rounded,
                child: TextField(
                  controller: bioController,
                  maxLines: 3,
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Write something about yourself',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF999999)),
                  ),
                ),
              ),

              // GENDER

              ProfileInputBox(
                title: 'Gender',
                icon: Icons.wc_rounded,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    isExpanded: true,
                    hint: const Text(
                      'Select Gender',
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => selectedGender = value);
                    },
                  ),
                ),
              ),

              // DATE OF BIRTH

              EditProfileOption(
                title: selectedDate == null
                    ? 'Date of Birth'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                icon: Icons.calendar_month_rounded,
                onTap: chooseDate,
              ),

              // COUNTRY

              ProfileInputBox(
                title: 'Country',
                icon: Icons.public_rounded,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCountry,
                    isExpanded: true,
                    hint: const Text(
                      'Select Country',
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(
                          country,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedCountry = value);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // THREE BOXES

              const ProfileSectionHeading(title: 'Profile Collection'),

              EditProfileOption(
                title: 'Frame',
                icon: Icons.crop_square_rounded,
                onTap: () => showComingSoon('Frame'),
              ),
              EditProfileOption(
                title: 'Teams',
                icon: Icons.groups_rounded,
                onTap: () => showComingSoon('Teams'),
              ),
              EditProfileOption(
                title: 'Ornament',
                icon: Icons.auto_awesome_rounded,
                onTap: () => showComingSoon('Ornament'),
              ),

              const SizedBox(height: 12),

              // FIVE BOXES

              const ProfileSectionHeading(title: 'Badges'),

              EditProfileOption(
                title: 'Entry',
                icon: Icons.login_rounded,
                onTap: () => showComingSoon('Entry'),
              ),
              EditProfileOption(
                title: 'Crown',
                icon: Icons.workspace_premium_rounded,
                onTap: () => showComingSoon('Crown'),
              ),
              EditProfileOption(
                title: 'Game Badge',
                icon: Icons.sports_esports_rounded,
                onTap: () => showComingSoon('Game Badge'),
              ),
              EditProfileOption(
                title: 'Money Badge',
                icon: Icons.paid_rounded,
                onTap: () => showComingSoon('Money Badge'),
              ),
              EditProfileOption(
                title: 'Gift Badge',
                icon: Icons.card_giftcard_rounded,
                onTap: () => showComingSoon('Gift Badge'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// EDIT PROFILE INPUT BOX

class ProfileInputBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const ProfileInputBox({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.fromLTRB(20, 17, 20, 15),
      decoration: profileBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileGoldIcon(icon: icon),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: black,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: child,
          ),
        ],
      ),
    );
  }
}

// EDIT PROFILE OPTION BOX

class EditProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const EditProfileOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: profileBoxDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                ProfileGoldIcon(icon: icon),
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

// GOLD ICON DESIGN

class ProfileGoldIcon extends StatelessWidget {
  final IconData icon;

  const ProfileGoldIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Icon(icon, color: black, size: 28),
    );
  }
}

// SECTION HEADING

class ProfileSectionHeading extends StatelessWidget {
  final String title;

  const ProfileSectionHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 5),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 25,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: black,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
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
                ProfileGoldIcon(icon: icon),
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
            child: Icon(icon, color: black, size: 55),
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
