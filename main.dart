import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // const MyApp({super.key, required this.todos});

  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyApp> {
  final todos = List<Todo>.generate(
    20,
    (i) => Todo(
      'Todo $i',
      'A description of what needs to be done for Todo $i',
    ),
  );

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 4, "name": "A01", "age": 35},
    {"id": 5, "name": "A02", "age": 21},
    {"id": 6, "name": "A03", "age": 55},
    {"id": 7, "name": "B01", "age": 30},
    {"id": 8, "name": "B02", "age": 14},
    {"id": 9, "name": "C01", "age": 100},
    {"id": 10, "name": "C02", "age": 32},
  ];
  final List<Map<String, dynamic>> _allUsers2 = [
    {"id": 1, "name": "Q11", "age": 29},
    {"id": 2, "name": "Q12", "age": 40},
    {"id": 3, "name": "Q13", "age": 5},
  ];
  final List<Map<String, dynamic>> _allUsers3 = [
    {"id": 1, "name": "Q11", "age": 29},
    {"id": 2, "name": "Q12", "age": 40},
    {"id": 3, "name": "Q13", "age": 5},
    {"id": 4, "name": "A01", "age": 35},
    {"id": 5, "name": "A02", "age": 21},
    {"id": 6, "name": "A03", "age": 55},
    {"id": 7, "name": "B01", "age": 30},
    {"id": 8, "name": "B02", "age": 14},
    {"id": 9, "name": "C01", "age": 100},
    {"id": 10, "name": "C02", "age": 32},
  ];
  List<Map<String, dynamic>> _foundUsers = [];
  // @override
  // initState() {
  //   // at the beginning, all users are shown
  //   _foundUsers = _allUsers;
  //   super.initState();
  // }

  final List<String> items = [
    'All',
    'F12P6',
    'F18P7',
  ];
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  String? selectedValue;
  String? value;
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_circle_outlined),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text('機台選擇', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(8),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      // wrap your Column in Expanded
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text('選擇廠區'),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                // buttonHeight: 40,
                                // buttonWidth: 140,
                                // itemHeight: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // wrap your Column in Expanded
                      child: Column(
                        children: <Widget>[
                          Container(
                            // Padding(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all()),
                            child: TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '輸入 Tool ID',
                                  // suffixIcon: Icon(Icons.search),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      // setState(() => {
                                      //       value = myController.text,
                                      //       // _runFilter(myController.text),
                                      //       // searchCountry(myController.text);
                                      //     });
                                      print(selectedValue);

                                      // _runFilter(myController.text.toString());
                                      if (identical(selectedValue, "F18P7")) {
                                        _runFilter(
                                            myController.text.toString());
                                      } else if (identical(
                                          selectedValue, "F12P6")) {
                                        _runFilter2(
                                            myController.text.toString());
                                      } else {
                                        _runFilter3(
                                            myController.text.toString());
                                      }
                                    },
                                    icon: Icon(Icons.search),
                                  )),
                            ),

                            // ),
                          )
                        ],
                      ),
                    ),
                  ]),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Tool ID:'),
                  ),
                ],
              ),
              new Expanded(
                // margin: EdgeInsets.all(10),
                // alignment: Alignment.topCenter,
                child: _foundUsers.isNotEmpty
                    ? Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.builder(
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(_foundUsers[index]["id"]),
                            color: Colors.amberAccent,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              onTap: () {
                                /* Option 1 */
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         DetailScreen(todo: todos[index]),
                                //   ),
                                // );
                                /* Option 2 */
                                _sendDataToSecondScreen(
                                    context, _foundUsers[index]['name']);
                              },
                              title: new Center(
                                  child: new Text(
                                _foundUsers[index]['name'],
                              )),
                            ),
                          ),
                        ))
                    : Text(
                        'No results found',
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context, String argStr) {
    String textToSend = argStr;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            text: textToSend,
          ),
        ));
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["name"]
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toString().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  void _runFilter2(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers2;
    } else {
      results = _allUsers2
          .where((user) => user["name"]
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toString().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  void _runFilter3(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers3;
    } else {
      results = _allUsers3
          .where((user) => user["name"]
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toString().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
}

// class Todo {
//   final String title;
//   final String description;

//   const Todo(this.title, this.description);
// }

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  // receive data from the FirstScreen as a parameter
  // SecondScreen({Key key, @required this.text}) : super(key: key);
  SecondScreen({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red, title: Text('Show Tool ID Info.')),
      body: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
