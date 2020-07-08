import 'package:BudgetApp/ViewModels/TrackViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TrackView extends StatefulWidget {
  @override
  _TrackViewState createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrackViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image(
              image: new AssetImage('asset/image/money.png'),
              height: 100,
              width: 100,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => TrackViewModel(),
    );
  }
}
