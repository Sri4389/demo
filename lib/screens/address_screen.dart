import 'package:flutter/material.dart';

class Address {
  final String name;
  final String phone;
  final String street;
  final String city;
  final String zip;
  final String state;

  Address({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.zip,
    required this.state,
  });
}

class ManageAddressScreen extends StatefulWidget {
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  List<Address> addressList = [
    Address(
      name: "John Doe",
      phone: "9876543210",
      street: "123 Main Street",
      city: "Hyderabad",
      zip: "500001",
      state: "Telangana",
    ),
  ];

  Address? selectedAddress;

  void _showAddressForm({Address? existingAddress, int? editIndex}) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: existingAddress?.name ?? "");
    final phoneController = TextEditingController(text: existingAddress?.phone ?? "");
    final streetController = TextEditingController(text: existingAddress?.street ?? "");
    final cityController = TextEditingController(text: existingAddress?.city ?? "");
    final zipController = TextEditingController(text: existingAddress?.zip ?? "");
    final stateController = TextEditingController(text: existingAddress?.state ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Form(
          key: formKey,
          child: Wrap(
            children: [
              Text(
                existingAddress == null ? 'Add Address' : 'Edit Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length != 10 ? "Enter valid phone" : null,
              ),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: "Street Address"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: "City"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: zipController,
                decoration: InputDecoration(labelText: "ZIP Code"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length < 5 ? "Enter valid ZIP" : null,
              ),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(labelText: "State"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text(existingAddress == null ? "Add" : "Update"),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newAddress = Address(
                      name: nameController.text,
                      phone: phoneController.text,
                      street: streetController.text,
                      city: cityController.text,
                      zip: zipController.text,
                      state: stateController.text,
                    );
                    setState(() {
                      if (editIndex != null) {
                        addressList[editIndex] = newAddress;
                        if (selectedAddress == existingAddress) {
                          selectedAddress = newAddress;
                        }
                      } else {
                        addressList.add(newAddress);
                      }
                    });
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Address?"),
        content: Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () {
              setState(() {
                if (selectedAddress == addressList[index]) {
                  selectedAddress = null;
                }
                addressList.removeAt(index);
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _continueToCheckout() {
    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a delivery address")),
      );
      return;
    }
    // Navigate to checkout and pass selectedAddress
    Navigator.pushNamed(context, '/checkout', arguments: selectedAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Addresses"),
      ),
      body: ListView.builder(
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          final address = addressList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("${address.name} - ${address.phone}"),
              subtitle: Text("${address.street}, ${address.city}, ${address.zip}, ${address.state}"),
              leading: Radio<Address>(
                value: address,
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() => selectedAddress = value);
                },
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showAddressForm(
                      existingAddress: address,
                      editIndex: index,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteAddress(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddressForm(),
        icon: Icon(Icons.add),
        label: Text("Add Address"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: _continueToCheckout,
          child: Text("Continue to Checkout"),
        ),
      ),
    );
  }
}
