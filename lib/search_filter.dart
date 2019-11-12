/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class SearchFilter extends StatefulWidget {
  final Function updateKeyword;

  SearchFilter(this.updateKeyword);

  @override
  State<StatefulWidget> createState() {
    return _SearchFilter(updateKeyword);
  }
}

class _SearchFilter extends State<SearchFilter> {
  static final List<String> filterOptions = <String>[
    "Bakery",
    "Bar",
    "Cafe",
    "Restaurant",
    "Supermarket"
  ];

  static const String _KEY_SELECTED_POSITION = "position";
  static const String _KEY_SELECTED_VALUE = "value";

  int _selectedPosition = 0;
  final Function updateKeyword;

  _SearchFilter(this.updateKeyword);

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text('Place preferences'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              selected: _selectedPosition == 0,
              leading: Icon(Icons.cake),
              title: Text(filterOptions[0]),
              onTap: () {
                _saveKeywordPreference(0);
              },
              trailing: _getIcon(0),
            ),
            ListTile(
              selected: _selectedPosition == 1,
              leading: Icon(Icons.local_bar),
              title: Text(filterOptions[1]),
              onTap: () {
                _saveKeywordPreference(1);
              },
              trailing: _getIcon(1),
            ),
            ListTile(
              selected: _selectedPosition == 2,
              leading: Icon(Icons.local_cafe),
              title: Text(filterOptions[2]),
              onTap: () {
                _saveKeywordPreference(2);
              },
              trailing: _getIcon(2),
            ),
            ListTile(
              selected: _selectedPosition == 3,
              leading: Icon(Icons.local_dining),
              title: Text(filterOptions[3]),
              onTap: () {
                _saveKeywordPreference(3);
              },
              trailing: _getIcon(3),
            ),
            ListTile(
              selected: _selectedPosition == 4,
              leading: Icon(Icons.local_grocery_store),
              title: Text(filterOptions[4]),
              onTap: () {
                _saveKeywordPreference(4);
              },
              trailing: _getIcon(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIcon(int value) {
    return Builder(
      builder: (BuildContext context) {
        if (value == _selectedPosition) {
          return Icon(Icons.check);
        } else {
          return SizedBox(
            width: 50,
          );
        }
      },
    );
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPosition = prefs.getInt(_KEY_SELECTED_POSITION) ?? 0;
    });
  }

  void _saveKeywordPreference(int position) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPosition = position;
      prefs.setString(_KEY_SELECTED_VALUE, filterOptions[position]);
      prefs.setInt(_KEY_SELECTED_POSITION, position);
      updateKeyword(filterOptions[position]);
    });
  }
}
