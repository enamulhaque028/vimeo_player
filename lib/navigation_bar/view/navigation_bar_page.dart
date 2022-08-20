import 'package:flutter/material.dart';
import 'package:vimeo_player/home/view/home_page.dart';
import '../cubit/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  PageController pageController = PageController(initialPage: 0);

  static final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Vimeo video player'),
            ),
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                context
                    .read<NavigationCubit>()
                    .onItemTapped(index);
                changeTab(index);
              },
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.indigo,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: 'News',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'History',
                  icon: Icon(Icons.history),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void changeTab(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}