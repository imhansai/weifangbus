import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

class SearchDemo extends StatefulWidget {
  SearchDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchDemoState createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  // 供选择的条目
  final _names = [
    'Igor Minar',
    'Brad Green',
    'Dave Geddes',
    'Naomi Black',
    'Greg Weber',
    'Dean Sofer',
    'Wes Alvaro',
    'John Scott',
    'Daniel Nadasi',
  ];

  // 选中的条目,默认 No one
  String _name = 'No one';

  final _formKey = GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context) {
    return MaterialPageRoute<String>(
        settings: RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return Material(
            child: MaterialSearch<String>(
              placeholder: '搜索线路',
              results: _names
                  .map((String v) => MaterialSearchResult<String>(
                        icon: Icons.person,
                        value: v,
                        text: "Mr(s). $v",
                      ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context).push(_buildMaterialSearchPage(context)).then((dynamic value) {
      setState(() => _name = value as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: Text("You found: ${_name ?? 'No one'}"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    MaterialSearchInput<String>(
                      placeholder: '搜索线路',
                      results: _names
                          .map((String v) => MaterialSearchResult<String>(
                                icon: Icons.person,
                                value: v,
                                text: "Mr(s). $v",
                              ))
                          .toList(),
                      filter: (dynamic value, String criteria) {
                        return value
                            .toLowerCase()
                            .trim()
                            .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                      },
                      onSelect: (dynamic v) {
                        print(v);
                      },
                      validator: (dynamic value) => value == null ? 'Required field' : null,
                      formatter: (dynamic v) => 'Hello, $v',
                    ),
                    MaterialButton(
                        child: Text('Validate'),
                        onPressed: () {
                          _formKey.currentState.validate();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMaterialSearch(context);
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
