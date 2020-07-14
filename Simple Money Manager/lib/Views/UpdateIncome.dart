import 'package:BudgetApp/ViewModels/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

class UpdateIncome extends StatefulWidget {
  @override
  _UpdateIncomeState createState() => _UpdateIncomeState();
}

class _UpdateIncomeState extends State<UpdateIncome> {
  TextEditingController incomeController = new TextEditingController();

  String errorMessage = "";

  Widget dialogContainer(BuildContext context) {
    var model = Provider.of<HomeViewModel>(context);
    String message = '';
    if (model.income == 0) {
      message = 'Add new income';
    } else {
      message = 'Update your income';
    }
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextField(
                  controller: incomeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: message,
                  ),
                ),
              ),
            ),
            Text(errorMessage),
            GestureDetector(
              child: Container(
                height: 30,
                child: Text('Next'),
              ),
              onTap: () async {
                try {
                  if (model.income == 0) {
                    await model.addNewIncome(income: incomeController.text);
                  } else {
                    await model.updateIncome(income: incomeController.text);
                  }
                  setState(() {
                    errorMessage = '';
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  setState(() {
                    errorMessage = 'Check your input';
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContainer(context),
    );
  }
}
