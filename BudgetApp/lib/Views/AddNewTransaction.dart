import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import '../Model/CategoryModel.dart';
import '../ViewModels/AddNewTransVM.dart';
import 'package:stacked/stacked.dart';
class CustomDialog extends StatefulWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Category selectedUser;

  TextEditingController nameController = new TextEditingController();
  TextEditingController spendController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  bool error = false;
  String errorMessage = "";

  Widget dialogContainer(BuildContext context) {
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
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Container(
              // Image
              height: MediaQuery.of(context).size.height / 3.5,
              child: Image(
                image: new AssetImage('asset/image/paying.png'),
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),
            Container(
              // Name
              width: double.infinity,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // Amount Money
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: TextField(
                      controller: spendController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ThousandsFormatter(),
                      ],
                      decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                  Container(
                    // Date
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextField(
                      controller: dateController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        DateInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Date',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<Category>(
                    hint: Text("Select Category"),
                    value: selectedUser,
                    onChanged: (Category value) {
                      setState(() {
                        selectedUser = value;
                      });
                    },
                    items: CategoryGetter.users.map((Category user) {
                      return DropdownMenuItem<Category>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                user.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                    onPressed: () async {
                      try {
                        // await addNewTrans.setValue(
                        //   name: nameController.text,
                        //   spend: spendController.text,
                        //   date: dateController.text,
                        //   category: selectedUser.name,
                        // );
                        setState(() {
                          errorMessage = "";
                        });
                      } catch (error) {
                        if (error.toString() == "Check your input") {
                          setState(() {
                            errorMessage = error.toString();
                          });
                        } else {
                          setState(() {
                            errorMessage = "Please choose a Category";
                          });
                        }
                      } finally {
                        if (errorMessage.isEmpty) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              child: Text(errorMessage),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewTransVM>.reactive(
      builder: (context, model, child) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContainer(context),
      ),
      viewModelBuilder: () => AddNewTransVM(),
    );
  }
}
