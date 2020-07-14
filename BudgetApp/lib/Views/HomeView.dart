import 'package:BudgetApp/Model/CategoryModel.dart';
import 'package:BudgetApp/ViewModels/HomeViewModel.dart';
import 'package:BudgetApp/ViewModels/TrackTimeViewModel.dart';
import 'package:BudgetApp/Views/UpdateIncome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    var timemodel = Provider.of<TrackTimeViewModel>(context);
    Provider.of<HomeViewModel>(context)
        .fetchData(month: timemodel.time.month, year: timemodel.time.year)
        .then((_) => {
              setState(() {
                _isLoading = false;
              })
            });
    super.didChangeDependencies();
  }

  Widget dailyspeendWidget({String date, String month, int total, var list}) {
    final formatCurrency = new NumberFormat("#,##0", "en_US");
    List<Widget> listTileWidget = [];
    for (var item in list) {
      listTileWidget.add(
        ListTile(
          leading: Image(
            image: AssetImage(CategoryGetter.getImage(item.category)),
            height: MediaQuery.of(context).size.height / 23,
          ),
          title: Text(
            item.name,
            style: TextStyle(fontSize: 15),
          ),
          trailing: Text(
            "-${formatCurrency.format(item.spend)}",
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    }

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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  '-${formatCurrency.format(total)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: listTileWidget,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeViewModel>(context);
    var timeModel = Provider.of<TrackTimeViewModel>(context);
    final formatCurrency = new NumberFormat("#,##0", "en_US");
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                              "${formatCurrency.format(model.income - model.totalSpend())}",
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
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) => UpdateIncome(),
                            );
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 10),
                            title: Text(
                              '${formatCurrency.format(model.income)}',
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
                            leading: Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Image(
                                image: new AssetImage('asset/image/income.png'),
                                color: null,
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                              ),
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
                          '${formatCurrency.format(model.totalSpend())}',
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
                        trailing: Container(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: Image(
                            image: new AssetImage('asset/image/expense.png'),
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.data.length,
                        itemBuilder: (ctx, index) {
                          String key = model.data.keys.elementAt(index);
                          int spend = 0;
                          for (var element in model.data[key]) {
                            spend += element.spend;
                          }
                          return dailyspeendWidget(
                            date: key,
                            month: timeModel.month,
                            total: spend,
                            list: model.data[key],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
