import 'package:BudgetApp/ViewModels/HomeViewModel.dart';
import 'package:BudgetApp/service/DataQuery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Dataquery>(context).getData(month: 7,year: 2020).then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget dailyspeendWidget({String date, String month, int total, var list}) {
    final formatCurrency = new NumberFormat("#,##0", "en_US");

    if (date == DateFormat.d().format(new DateTime.now()).toString()) {
      date = 'Today';
    } else if (date ==
        (int.parse(DateFormat.d().format(new DateTime.now()).toString()) - 1)
            .toString()) {
      date = 'Yesterday';
    } else {
      date = month + " " + date;
    }

    return Container(
      padding: EdgeInsets.only(top: 15),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$date',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  '-${formatCurrency.format(total)}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(
                  list[index].name,
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Text(
                  "-${formatCurrency.format(total)}",
                  style: TextStyle(fontSize: 15),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeViewModel>(context);
    var data = Provider.of<Dataquery>(context);
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.month,
                style: TextStyle(
                  fontFamily: 'Sriracha',
                  fontSize: 20,
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height - 40) / 6,
                width: double.infinity,
                child: Card(
                  color: Colors.lightGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "18,000,000",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Image(
                          image: new AssetImage('asset/image/money.png'),
                          color: null,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Container(
                    height: (MediaQuery.of(context).size.height - 40) / 6,
                    child: Card(
                      color: Colors.lightBlue,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            model.prints(context);
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 10),
                            title: Text(
                              '30,000,000',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              'Income',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '2%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height - 40) / 6,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    color: Colors.red,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        title: Text(
                          '12,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          'Expense',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '-5%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.greenAccent,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              // Expanded(
              //   child: _isLoading
              //       ? Center(
              //           child: CircularProgressIndicator(),
              //         )
              //       : Text(model.counter.toString()),
              //   // : ListView.builder(
              //   //     shrinkWrap: true,
              //   //     itemCount: model.data.length,
              //   //     itemBuilder: (ctx, index) {
              //   //       String key = model.data.keys.elementAt(index);
              //   //       int spend = 0;
              //   //       for (var element in model.data[key]) {
              //   //         spend += element.spend;
              //   //       }
              //   //       return dailyspeendWidget(
              //   //         date: key,
              //   //         month: model.month,
              //   //         total: spend,
              //   //         list: model.data[key],
              //   //       );
              //   //     },
              //   //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
