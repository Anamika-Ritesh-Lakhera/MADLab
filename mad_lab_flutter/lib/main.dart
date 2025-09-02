import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MadLabApp());

class MadLabApp extends StatelessWidget {
  const MadLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Lab Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProfileCardPage(),
    const RatingPage(),
    const RichTextTogglePage(),
    const RegistrationFormPage(),
    const DynamicFormPage(),
    const DatePickerFormPage(),
    const SpotifyPage(),
    const DraggableNotesPage(),
    const CustomBottomNavDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MAD Lab Project")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Rating"),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: "RichText"),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: "Form"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Dynamic Form"),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "Date Form"),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "Spotify"),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: "Notes"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Nav Demo"),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

//////////////////////////////
/// SUB-TASK 1.1 Profile Card
//////////////////////////////
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
                ),
                const SizedBox(height: 10),
                const Text("John Doe",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("Flutter Developer",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(children: [Text("120"), Text("Posts")]),
                    Column(children: [Text("4.5k"), Text("Followers")]),
                    Column(children: [Text("300"), Text("Following")]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////
/// SUB-TASK 1.2 Rating Widget
//////////////////////////////
class RatingPage extends StatefulWidget {
  const RatingPage({super.key});
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(index < _rating ? Icons.star : Icons.star_border),
              color: Colors.amber,
              onPressed: () => setState(() => _rating = index + 1),
            );
          }),
        ),
        Text("Rating: $_rating/5")
      ],
    );
  }
}

//////////////////////////////
/// SUB-TASK 1.3 RichText Toggle
//////////////////////////////
class RichTextTogglePage extends StatefulWidget {
  const RichTextTogglePage({super.key});
  @override
  State<RichTextTogglePage> createState() => _RichTextTogglePageState();
}

class _RichTextTogglePageState extends State<RichTextTogglePage> {
  bool _showFullText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            children: [
              const TextSpan(text: "Flutter makes it easy... "),
              if (_showFullText)
                const TextSpan(
                    text:
                        "by providing rich UI widgets, layouts, and gesture support for developers."),
            ],
          ),
        ),
        TextButton(
          child: Text(_showFullText ? "Read Less" : "Read More"),
          onPressed: () => setState(() => _showFullText = !_showFullText),
        )
      ],
    );
  }
}

//////////////////////////////
/// SUB-TASK 2.1 Multi-step Form
//////////////////////////////
class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key});
  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _step = 1;
  String? email, password, name, phone;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _step == 1
            ? Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (v) =>
                        v != null && v.contains("@") ? null : "Invalid Email",
                    onSaved: (v) => email = v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (v) =>
                        v != null && v.length >= 6 ? null : "Min 6 chars",
                    onSaved: (v) => password = v,
                  ),
                  ElevatedButton(
                    child: const Text("Next"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() => _step = 2);
                      }
                    },
                  )
                ],
              )
            : Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Name"),
                    onSaved: (v) => name = v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Phone"),
                    keyboardType: TextInputType.phone,
                    onSaved: (v) => phone = v,
                  ),
                  ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Registration Success!")),
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}

//////////////////////////////
/// SUB-TASK 2.2 Dynamic Form
//////////////////////////////
class DynamicFormPage extends StatefulWidget {
  const DynamicFormPage({super.key});
  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  final List<TextEditingController> _controllers = [];

  void _addField() {
    setState(() => _controllers.add(TextEditingController()));
  }

  void _removeField(int i) {
    setState(() => _controllers.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ..._controllers.asMap().entries.map((entry) {
          int i = entry.key;
          return Row(
            children: [
              Expanded(child: TextField(controller: entry.value)),
              IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => _removeField(i))
            ],
          );
        }),
        ElevatedButton.icon(
          onPressed: _addField,
          icon: const Icon(Icons.add),
          label: const Text("Add Field"),
        )
      ],
    );
  }
}

//////////////////////////////
/// SUB-TASK 2.3 Date Picker Form
//////////////////////////////
class DatePickerFormPage extends StatefulWidget {
  const DatePickerFormPage({super.key});
  @override
  State<DatePickerFormPage> createState() => _DatePickerFormPageState();
}

class _DatePickerFormPageState extends State<DatePickerFormPage> {
  DateTime? _selectedDate;
  final _controller = TextEditingController();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: "Date of Birth"),
            readOnly: true,
            onTap: _pickDate,
          ),
          ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              if (_selectedDate != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("DOB: ${_controller.text}")),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

//////////////////////////////
/// SUB-TASK 3.1 Spotify Page
//////////////////////////////
class SpotifyPage extends StatelessWidget {
  const SpotifyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network("https://picsum.photos/400/600",
              fit: BoxFit.cover, height: double.infinity, width: double.infinity),
          Container(color: Colors.black54),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text("Album Title",
                    style: TextStyle(color: Colors.white, fontSize: 28)),
                const Text("Artist Name", style: TextStyle(color: Colors.white70)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.shuffle, color: Colors.white),
                    Icon(Icons.skip_previous, color: Colors.white),
                    Icon(Icons.play_circle, color: Colors.white, size: 40),
                    Icon(Icons.skip_next, color: Colors.white),
                    Icon(Icons.repeat, color: Colors.white),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (_, __) => const Divider(color: Colors.white),
                  itemBuilder: (_, i) =>
                      ListTile(title: Text("Song $i", style: const TextStyle(color: Colors.white))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////
/// SUB-TASK 3.2 Draggable Notes
//////////////////////////////
class DraggableNotesPage extends StatefulWidget {
  const DraggableNotesPage({super.key});
  @override
  State<DraggableNotesPage> createState() => _DraggableNotesPageState();
}

class _DraggableNotesPageState extends State<DraggableNotesPage> {
  List<Offset> _positions = [const Offset(100, 100)];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._positions.asMap().entries.map((entry) {
          int i = entry.key;
          Offset pos = entry.value;
          return Positioned(
            left: pos.dx,
            top: pos.dy,
            child: GestureDetector(
              onPanUpdate: (d) {
                setState(() {
                  _positions[i] = Offset(pos.dx + d.delta.dx, pos.dy + d.delta.dy);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: const Center(child: Text("Note")),
              ),
            ),
          );
        }),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() => _positions.add(const Offset(50, 50)));
            },
          ),
        )
      ],
    );
  }
}

//////////////////////////////
/// SUB-TASK 3.3 Custom Nav Demo
//////////////////////////////
class CustomBottomNavDemo extends StatefulWidget {
  const CustomBottomNavDemo({super.key});
  @override
  State<CustomBottomNavDemo> createState() => _CustomBottomNavDemoState();
}

class _CustomBottomNavDemoState extends State<CustomBottomNavDemo> {
  int _index = 0;
  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_index],
      ),
      bottomNavigationBar: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            return GestureDetector(
              onTap: () => setState(() => _index = i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(i == 0 ? Icons.home : i == 1 ? Icons.search : Icons.person,
                      color: _index == i ? Colors.blue : Colors.grey),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      i == 0 ? "Home" : i == 1 ? "Search" : "Profile",
                      style: TextStyle(
                          fontSize: _index == i ? 16 : 12,
                          color: _index == i ? Colors.blue : Colors.grey),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
