import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _users = [];
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _users.add({
          'name': _nameController.text,
          'phone': _phoneController.text,
        });
        _nameController.clear();
        _phoneController.clear();
      });
    }
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
    });
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel, color: Colors.cyan),
              label:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton.icon(
              onPressed: () {
                _deleteUser(index);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete, color: Colors.cyan),
              label:
                  const Text('Delete', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                      16.0), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Set the background color to gray
                    border: Border.all(
                      color: Colors.blue, // Set the color of the border
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Set the border radius
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.blue, // Set the color of the border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16), // Add space between fields
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.blue, // Set the color of the border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _addUser,
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          _showDeleteConfirmationDialog(index);
                        },
                        child: Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(_users[index]['name']!),
                            subtitle: Text(_users[index]['phone']!),
                            trailing: const Icon(Icons.phone),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
