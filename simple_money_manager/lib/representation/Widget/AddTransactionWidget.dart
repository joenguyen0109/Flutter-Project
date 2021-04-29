import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
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
                  child: Text('errorMessage'),
                ),
                //Image
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

                //Image

                Container(
                  // Name
                  width: double.infinity,
                  child: TextField(
                    //controller: nameController,
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
                          //controller: spendController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            //ThousandsFormatter(),
                          ],
                          decoration: InputDecoration(
                            icon: Icon(Icons.attach_money),
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                      // Container(
                      //   // Date
                      //   width: MediaQuery.of(context).size.width / 2.5,
                      //   child: TextField(
                      //     //controller: dateController,
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: [
                      //       //DateInputFormatter(),
                      //     ],
                      //     decoration: InputDecoration(
                      //       icon: Icon(Icons.date_range),
                      //       labelText: 'Date',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // TypeAheadFormField(
                //   direction: AxisDirection.up,

                //   textFieldConfiguration: TextFieldConfiguration(
                //       //controller: this._typeAheadController,
                //       decoration: InputDecoration(labelText: 'Category')),
                //   suggestionsCallback: (pattern) async {
                //     return await DataAPI.getSuggestions(pattern);
                //   },
                //   itemBuilder: (context, suggestion) {
                //     return ListTile(
                //       title: Text(suggestion),
                //     );
                //   },
                //   transitionBuilder: (context, suggestionsBox, controller) {
                //     return suggestionsBox;
                //   },
                //   onSuggestionSelected: (suggestion) {
                //     //this._typeAheadController.text = suggestion;
                //   },
                //   //validator: (value) {},
                //   onSaved: (value) {},
                // ),
                // Container(
                //   padding: EdgeInsets.only(top: 20),
                //   child: DropdownButton<Category>(
                //     hint: Text("Select Category"),
                //     value: selectedUser,
                //     onChanged: (Category value) {
                //       setState(() {
                //         selectedUser = value;
                //       });
                //     },
                //     items: CategoryGetter.users.map((Category user) {
                //       return DropdownMenuItem<Category>(
                //         value: user,
                //         child: Row(
                //           children: <Widget>[
                //             Container(
                //               child: Text(
                //                 user.name,
                //                 style: TextStyle(color: Colors.black),
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: FloatingActionButton(
                //     child: Icon(Icons.add),
                //     backgroundColor: Colors.green,
                //     onPressed: () async {},
                //   ),
                // ),
              ],
            )
            // : Column(
            //     children: [
            //       Expanded(
            //         child: Center(
            //           child: TextField(
            //             controller: incomeController,
            //             keyboardType: TextInputType.number,
            //             inputFormatters: [
            //               ThousandsFormatter(),
            //             ],
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(),
            //               labelText: 'Add your income',
            //             ),
            //           ),
            //         ),
            //       ),
            //       Text(errorMessage),
            //       GestureDetector(
            //         child: Container(
            //           height: 30,
            //           child: Text('Next'),
            //         ),
            //         onTap: () async {
            //           try {
            //             await model.addNewIncome(
            //                 income: incomeController.text);
            //             setState(() {
            //               errorMessage = '';
            //             });
            //           } catch (e) {
            //             setState(() {
            //               errorMessage = 'Check your input';
            //             });
            //           }
            //         },
            //       ),
            //     ],
            //   ),
            ),
      ),
    );
  }
}
