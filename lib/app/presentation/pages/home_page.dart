import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/data/blocs/selection/selection_bloc.dart';
import 'package:flutter_web/app/presentation/pages/print_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';
import 'history_screen.dart';
import 'clients_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<BottomNavigationBarItem> _navBarItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined),
    activeIcon: Icon(Icons.shopping_cart_rounded),
    label: 'Order',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Clients',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.history_outlined),
    activeIcon: Icon(Icons.history_rounded),
    label: 'History',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.print_outlined),
    activeIcon: Icon(Icons.print_rounded),
    label: 'Print',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.logout_outlined),
    activeIcon: Icon(Icons.logout),
    label: 'Logout',
  ),
];

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  bool _isExtended = true;
  String? _title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isMediumScreen = width >= 600 && width <= 1024;
    final bool isLargeScreen = width > 1024;

    return Scaffold(
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: _navBarItems,
              currentIndex: _selectedIndex.value,
              onTap: (int index) {
                if (index == 5) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _selectedIndex.value = index;
                  });
                }
              })
          : null,
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              //add title to the navigation rail
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: BlocBuilder<SelectionBloc, SelectionState>(
                  builder: (context, state) {
                    // return Text(
                    //   _title ?? ' ',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // );
                    if (state is SelectionPOD) {
                      return Text(
                        'POD',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else if (state is SelectionOffset) {
                      return Text(
                        'Offset',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return Text(
                        ' ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
              ),
              selectedIndex: _selectedIndex.value,
              onDestinationSelected: (int index) {
                //if logout context.pop
                if (index == 5) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _selectedIndex.value = index;
                  });
                }
              },
              extended: _isExtended,
              destinations: _navBarItems
                  .map(
                    (item) => NavigationRailDestination(
                      icon: item.icon,
                      selectedIcon: item.activeIcon,
                      label: Text(
                        item.label!,
                      ),
                    ),
                  )
                  .toList(),
              trailing: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isExtended = !_isExtended;
                  });
                },
                child: Icon(
                  _isExtended ? Icons.arrow_back : Icons.arrow_forward,
                ),
              ),
            ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          // This is the main content.
          Expanded(
            child: _selectedScreen(_selectedIndex.value),
          )
        ],
      ),
    );
  }

  Widget _selectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const OrderScreen();
      case 2:
        return const ClientsScreen();
      case 3:
        return const HistoryScreen();
      case 4:
        return const PrintScreen();
      case 5:
        return Container();
      default:
        return const HomeScreen();
    }
  }
}
