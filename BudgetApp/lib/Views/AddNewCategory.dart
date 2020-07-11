import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  var _pageNum = 0;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.fontAwesomeIcons);

    print('Picked Icon:  $icon');
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget dialogContainer(BuildContext context) {
    var page1 = Container(
      height: MediaQuery.of(context).size.height / 1.9,
      width: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: TextField(),
      ),
    );
    var page2 = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.9,
          child: BlockPicker(
            pickerColor: currentColor,
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
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (_pageNum == 1) {
                      await _pickIcon();
                    } else {
                      setState(() {
                        _pageNum++;
                      });
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
