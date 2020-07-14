import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../ViewModels/TrackTimeViewModel.dart';
import '../ViewModels/TrackViewModel.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../Model/CategoryModel.dart';

class TrackView extends StatefulWidget {
  @override
  _TrackViewState createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    var timemodel = Provider.of<TrackTimeViewModel>(context);
    Provider.of<TrackViewModel>(context)
        .fetchData(month: timemodel.time.month, year: timemodel.time.year)
        .then((_) => {
              setState(() {
                _isLoading = false;
              })
            });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TrackViewModel>(context);
    final formatCurrency = new NumberFormat("#,##0", "en_US");
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: model.data.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(CategoryGetter.getImage(
                                        model.data[index]['category'])),
                                    height:
                                        MediaQuery.of(context).size.height / 23,
                                  ),
                                  title: Text(model.data[index]['category']),
                                  trailing: Text(
                                    "-\$${formatCurrency.format(model.data[index]['catTotal'])}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 50,
                                  animation: true,
                                  lineHeight: 30.0,
                                  animationDuration: 2500,
                                  percent: model.data[index]['catTotal'] /
                                      model.getTotal(),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                              .toInt())
                                      .withOpacity(1.0),
                                ),
                              ],
                            ),
                          );
                          //return Text(model.data[index]['category']);
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
