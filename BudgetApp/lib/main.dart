import 'package:BudgetApp/service/DataQuery.dart';
import 'package:flutter/material.dart';
import 'Views/HomeView.dart';
import 'Views/TrackView.dart';
import './service/locator.dart';
import './Views/AddNewTransaction.dart';
import 'package:provider/provider.dart';
import './ViewModels/HomeViewModel.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Dataquery(),
        ),
        ChangeNotifierProvider.value(
          value: HomeViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'BalsamiqSans',
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  static const routeName = '/mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  final _page = [
    HomeView(),
    TrackView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedPage],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext ctx) => CustomDialog(
              title: "test",
              description: "this line of code",
              buttonText: "Process",
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 5.0,
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: BottomNavigationBar(
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "",
                style: new TextStyle(fontSize: 0),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(
                "",
                style: new TextStyle(fontSize: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
