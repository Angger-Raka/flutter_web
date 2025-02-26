import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/app/core/constants/constant.dart';
import 'package:flutter_web/app/data/data.dart';
import 'package:flutter_web/routes.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  Map<String, List> items = {
    'Offset': [
      Icons.dashboard,
      '/dashboard',
    ],
    'POD': [
      Icons.shopping_cart,
      '/orders',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectionBloc, SelectionState>(
      listener: (context, state) {
        print('SelectionBloc: $state');
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Tentukan lebar tetap untuk setiap item
            double itemWidth = 300;
            int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    crossAxisCount, // Jumlah kolom berdasarkan lebar layar
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1, // Rasio aspek dari item grid
              ),
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                String title = items.keys.elementAt(index);
                IconData icon = items[title]![0];
                // String route = items[title]![1];

                return _buildCard(
                  icon,
                  title,
                  () async {
                    context.read<SelectionBloc>().add(
                          SelectionChange(
                            title == 'Offset'
                                ? Selection.offset
                                : Selection.pod,
                          ),
                        );

                    context.push(NamedRoutes.home);

                    // context.push(NamedRoutes.home);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
