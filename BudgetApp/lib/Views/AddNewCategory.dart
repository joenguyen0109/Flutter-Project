import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import '../Model/CategoryModel.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  var _pageNum = 0;
  Color pickerColor = Colors.blue;
  String _errormMessage = '';
  TextEditingController _titleController = new TextEditingController();
  IconData _icon;

  Future<IconData> _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.material);

    return icon;
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget dialogContainer(BuildContext context) {
    print('----');
    CategoryGetter.users.forEach((element) {
      print(element.name);
    });
    var page1 = Container(
      height: MediaQuery.of(context).size.height / 1.9,
      width: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: "Add new Category",
          ),
        ),
      ),
    );
    var page2 = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.9,
          child: BlockPicker(
            pickerColor: Colors.blue,
            onColorChanged: changeColor,
          ),
        ),
      ],
    );
    var page3 = Text('test2');
    List<Widget> widgets = [page1, page2, page3];

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
          children: <Widget>[
            widgets[_pageNum],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_pageNum == 0) {
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        _pageNum--;
                      });
                    }
                  },
                ),
                Text(_errormMessage),
                FloatingActionButton(
                  backgroundColor: Color(0xffffeb3b),
                  child: Icon(_icon),
                  onPressed: () async {
                    if (_pageNum == 0) {
                      if (_titleController.text.isEmpty) {
                        setState(() {
                          _errormMessage = 'Please fill in!';
                        });
                      } else if (CategoryGetter.alreayExist(
                          _titleController.text)) {
                        setState(() {
                          _errormMessage = 'Category already exist';
                        });
                      } else {
                        setState(() {
                          _errormMessage = '';
                          _pageNum++;
                        });
                      }
                    } else if (_pageNum == 1) {
                      var icon = await _pickIcon();
                      if (icon != null) {
                        setState(() {
                          _icon = icon;
                        });
                        CategoryGetter.users.add(new Category(
                            _titleController.text, Icon(_icon), pickerColor));
                        print(_icon.codePoint);
                        print(_icon.codePoint.toRadixString(16).toUpperCase());
                        print(_icon.codePoint
                            .toRadixString(16)
                            .toUpperCase()
                            .padLeft(5, '0'));
                        print(_icon.toString());
                        print(pickerColor.toString());
                        //Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
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
