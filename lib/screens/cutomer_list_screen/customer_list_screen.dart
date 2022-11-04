// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomerListscreen extends StatelessWidget {
  const CustomerListscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController CustomerNamecontroller = TextEditingController();
    TextEditingController CustomerPhonenocontroller = TextEditingController();
    TextEditingController CustomerEmailcontroller = TextEditingController();
    TextEditingController CustomerAddresscontroller = TextEditingController();

    Future<void> update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        CustomerNamecontroller.text = documentSnapshot['Name'];
        CustomerPhonenocontroller.text = documentSnapshot['PhoneNo'];
        CustomerEmailcontroller.text = documentSnapshot['Email'];
        CustomerAddresscontroller.text = documentSnapshot['Address'];
      }
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: CustomerNamecontroller,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: CustomerPhonenocontroller,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      CustomerPhonenocontroller =
                          double.tryParse(val) as TextEditingController;
                    },
                    decoration: const InputDecoration(labelText: 'Phone no'),
                  ),
                  TextField(
                    controller: CustomerEmailcontroller,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: CustomerAddresscontroller,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String name = CustomerNamecontroller.text;
                      // ignore: unnecessary_nullable_for_final_variable_declarations
                      final double? phonenumber =
                          double.parse(CustomerPhonenocontroller.text);
                      final String EmailID = CustomerEmailcontroller.text;
                      final String Address = CustomerAddresscontroller.text;
                      // ignore: unnecessary_null_comparison
                      if (name != null) {
                        await FirebaseFirestore.instance
                            .collection('/Customer')
                            .doc(documentSnapshot!.id)
                            .update({
                          "Name": name,
                          "PhoneNo": phonenumber,
                          "Email": EmailID,
                          "Address": Address,
                        });
                        CustomerNamecontroller.text = '';
                        CustomerPhonenocontroller.text = '';
                        CustomerEmailcontroller.text = '';
                        CustomerAddresscontroller.text = '';
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Update'),
                  )
                ],
              ),
            );
          });
    }

    Future<void> delete(String CustomerID) async {
      await FirebaseFirestore.instance
          .collection("/Customer")
          .doc(CustomerID)
          .delete();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have successfully deleted Customer contact'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
      ),
      bottomNavigationBar: GNav(
        gap: 5,
        tabs: [
          GButton(
            onPressed: () {
              Get.toNamed("/home");
            },
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            active: true,
            onPressed: () {
              Get.toNamed("/customer");
            },
            icon: Icons.person_add,
            text: 'customer',
          ),
          GButton(
            onPressed: () {
              Get.offAndToNamed("/product");
            },
            icon: Icons.shopping_basket,
            text: 'product',
          ),
          GButton(
            onPressed: () {
              Get.offAndToNamed("/profile");
            },
            icon: Icons.person,
            text: 'profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Divider(),
            TextFormField(
              controller: CustomerNamecontroller,
              decoration: const InputDecoration(
                labelText: ' Name',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: CustomerPhonenocontroller,
              decoration: const InputDecoration(
                labelText: 'Phone no',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: CustomerEmailcontroller,
              decoration: const InputDecoration(
                labelText: 'Email Id',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 5,
              controller: CustomerAddresscontroller,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Map<String, dynamic> customer = {
                      "Name": CustomerNamecontroller.text,
                      "PhoneNo":
                          double.tryParse(CustomerPhonenocontroller.text),
                      "Email": CustomerEmailcontroller.text,
                      "Address": CustomerAddresscontroller.text,
                    };
                    FirebaseFirestore.instance
                        .collection("Customer")
                        .add(customer)
                        .then((value) {
                      Navigator.of(context).popAndPushNamed('/customer');
                    });
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text('Show All Customer'),
                ),
              ],
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("/Customer")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['Name']),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => update(documentSnapshot),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => delete(documentSnapshot.id),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
