import 'package:flutter_task_broken/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_broken/model/comment.dart';
import 'package:flutter_task_broken/model/post.dart';
import 'package:flutter_task_broken/services/remoteservice.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  List<dynamic> countries = [];
  List<dynamic> statesMasters = [];
  List<dynamic> states = [];

  String? countryId;
  String? stateId;

  @override
  void initState() {
    getPosts();

    super.initState();

    this.countries.add({"id": 1, "label": "India"});
    this.countries.add({"id": 2, "label": "UAE"});

    this.statesMasters = [
      {"ID": 1, "Name": "Assam", "ParentId": 1},
      {"ID": 2, "Name": "Delhi", "ParentId": 1},
      {"ID": 3, "Name": "Bihar", "ParentId": 1},
      {"ID": 4, "Name": "Kolkata", "ParentId": 1},
      {"ID": 1, "Name": "Abu Dhabi", "ParentId": 2},
      {"ID": 2, "Name": "Dubai", "ParentId": 2},
      {"ID": 3, "Name": "Sharjah", "ParentId": 2},
      {"ID": 4, "Name": "Ajman", "ParentId": 2},
    ];
  }

  // my code
  List<Posts>? posts = [];
  List<Comments>? comments = [];

  // get category
  getPosts() async {
    List<Posts>? response = await RemoteService().getPosts();

    setState(() {
      stateController.clear();
      comments = [];

      posts = response;
    });
  }

  // get Sub category
  getSubCategory(String commentID) async {
    List<Comments>? response =
    await RemoteService().getComment(commentId: commentID);

    setState(() {
      comments = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            const SizedBox(height: 10),

            // my code starts here
            const SizedBox(height: 10),
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // Add more decoration..
              ),
              hint: const Text(
                'Choose Country',
                style: TextStyle(fontSize: 14),
              ),
              items: posts?.map((items) {
                return DropdownMenuItem<String>(
                  value: items.id.toString(),
                  child: Text(items.title),
                );
              }).toList() ??
                  [],
              validator: (value) {
                if (value == null) {
                  return 'Please select any one option.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when selected item is changed.
                setState(() {
                  countryController.text = value.toString();
                  getSubCategory(countryController.text);
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),

            const SizedBox(height: 24.0),

            // second dropdown

            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              hint: const Text(
                'Choose State',
                style: TextStyle(fontSize: 14),
              ),
              items: comments?.map((items) {
                return DropdownMenuItem<String>(
                  value: items.body,
                  child: Text(items.name),
                );
              }).toList() ??
                  [],
              validator: (value) {
                if (value == null) {
                  return 'Please select any one option.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when selected item is changed.
                setState(() {
                  stateController.text = value.toString();
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),

            // my code ends here

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts.add(Contact(name: name, contact: contact));
                        });
                      }
                      //
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text(
              'No Contact yet..',
              style: TextStyle(fontSize: 22),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
