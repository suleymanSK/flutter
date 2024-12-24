import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ExpensesScreen(),
    TodoScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Harcamalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Yapılacaklar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Hesabım',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Map<String, String>> expenses = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedCurrency = 'TL';

  void _addExpense() {
    final amount = double.tryParse(amountController.text);
    if (titleController.text.isNotEmpty &&
        amount != null &&
        amount > 0 &&
        selectedCurrency != null) {
      setState(() {
        expenses.add({
          'title': titleController.text,
          'amount': '${amount.toString()} $selectedCurrency',
        });
        titleController.clear();
        amountController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Hata'),
          content: Text('Geçerli bir tutar ve para birimi giriniz.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(expenses[index]['title']!),
                  subtitle: Text(expenses[index]['amount']!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        expenses.removeAt(index);
                      });
                    },
                  ),
                  leading: Icon(Icons.money),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Harcamalar Başlığı'),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Tutar'),
                ),
              ),
              DropdownButton<String>(
                value: selectedCurrency,
                items: ['TL', 'USD', 'EUR'].map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addExpense,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<String> todos = [
    'Alışveriş yap',
    'Evi temizle',
    'Projeyi hazırla'
  ];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todos.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(todos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Yeni yapılacak ekle'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addTodo,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController userNameController =
      TextEditingController(text: "Kullanıcı Adı: Suleyman");
  final TextEditingController userIdController =
      TextEditingController(text: "Hesap ID: 123456");

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isEditing) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(labelText: 'Hesap ID'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = false;
                });
              },
              child: Text('Kaydet'),
            ),
          ] else ...[
            Text(userNameController.text, style: TextStyle(fontSize: 21)),
            Text(userIdController.text, style: TextStyle(fontSize: 21)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: Text('Bilgileri Düzenle'),
            ),
          ]
        ],
      ),
    );
  }
}
