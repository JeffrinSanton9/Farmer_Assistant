import 'package:flutter/material.dart';
import 'screens/market_tab.dart';
import 'screens/community_tab.dart';
import 'screens/assistant_tab.dart';
import 'screens/home_tab.dart';

void main() {
  runApp(const Frontend());
}

class Frontend extends StatelessWidget {
  const Frontend({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agri AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const MainTabs(),
    );
  }
}

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _selectedTab = 0;

  static final List<Widget> Screens = <Widget>[
    const HomeTabView(),
    const AssistantTabView(),
    const CommunityTabView(),
    const MarketTabScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _goToAssistantTab() {
    setState(() {
      _selectedTab = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Home', 'Assistant', 'Community', 'Market'][_selectedTab]),
      ),
      body: Screens[_selectedTab],
      floatingActionButton: _selectedTab == 0
          ? FloatingActionButton(
              onPressed: _goToAssistantTab,
              tooltip: 'Chat with Assistant',
              child: const Icon(Icons.arrow_forward),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assistant), label: 'Assistant'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Market'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
