import 'package:flutter/material.dart';
import 'package:flutter_web/app/core/constants/named_routes.dart';
import 'package:flutter_web/app/core/core.dart';
import 'package:go_router/go_router.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    var mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context.push(NamedRoutes.order);
              },
              child: Container(
                width: mediaWidth > 600 ? 200 : 150,
                height: mediaWidth > 600 ? 200 : 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.assignment,
                        size: mediaWidth > 600 ? 100 : 70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'List Orderan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.push(NamedRoutes.orderCreate);
              },
              child: Container(
                width: mediaWidth > 600 ? 200 : 150,
                height: mediaWidth > 600 ? 200 : 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.add_shopping_cart,
                        size: mediaWidth > 600 ? 100 : 70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tambah Orderan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
