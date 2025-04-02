import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/database.dart';
import 'package:pharma_application/pages/doctorNamePage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> imageAdds = [
    'assets/images/med1.jpg',
    'assets/images/med2.jpg',
    'assets/images/med3.jpg',
    'assets/images/med4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Database db = Database();
    final String doctorName = db.getdatabase("doctorName");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.secularOne(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 26,
              ));
        }),
        actions: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 28,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                " Dr. $doctorName",
                style: GoogleFonts.secularOne(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(child: Image.asset('assets/images/logo.jpg')),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text(
                  "Home",
                  style: GoogleFonts.secularOne(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
            Spacer(), // Pushes logout to the bottom
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 45),
              child: ListTile(
                title: Text(
                  "Logout",
                  style: GoogleFonts.secularOne(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorNamePage(
                                db: db,
                              )));
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 500.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: imageAdds.map((Add) {
              return Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(Add),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          // Text(
          //   "Explore our latest medicines and research",
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
