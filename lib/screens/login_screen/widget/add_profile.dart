import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  String _gender = "";
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        )),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight),
            ),
            child: InkWell(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey.withOpacity(0.5)),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Enter your data profile",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.black),
          ),
          Text("Ensure your data profile is correct"),
          Container(
            padding: EdgeInsets.all(25),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: "ivan@gmail.com",
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              filled: true, labelText: "First Name"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              filled: true, labelText: "Last Name"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        filled: true, labelText: "Phone Number"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: "Male",
                          items: ['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _gender = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          decoration: InputDecoration(
                              labelText: "Date",
                              prefixIcon: InkWell(
                                onTap: () => _selectDate(),
                                child: Icon(Icons.date_range),
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent])),
              child: Text(
                "Submit Data",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
