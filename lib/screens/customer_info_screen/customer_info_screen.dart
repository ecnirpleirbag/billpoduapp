import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerInfoscreen extends StatelessWidget {
  const CustomerInfoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController customerNamecontroller = TextEditingController();
    TextEditingController customerPhonenocontroller = TextEditingController();
    TextEditingController customerEmailcontroller = TextEditingController();
    TextEditingController customerAddresscontroller = TextEditingController();

    Future<void> update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        customerNamecontroller.text = documentSnapshot['Name'];
        customerPhonenocontroller.text = documentSnapshot['PhoneNo'];
        customerEmailcontroller.text = documentSnapshot['Email'];
        customerAddresscontroller.text = documentSnapshot['Address'];
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
                    controller: customerNamecontroller,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: customerPhonenocontroller,
                    decoration: const InputDecoration(labelText: 'Phone no'),
                  ),
                  TextField(
                    controller: customerEmailcontroller,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: customerAddresscontroller,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String name = customerNamecontroller.text;
                      final double? phonenumber =
                          double.tryParse(customerPhonenocontroller.text);
                      final String emailID = customerEmailcontroller.text;
                      final String address = customerAddresscontroller.text;
                      // ignore: unnecessary_null_comparison
                      if (name != null) {
                        await FirebaseFirestore.instance
                            .collection('/Customer')
                            .doc(documentSnapshot!.id)
                            .update({
                          "Name": name,
                          "PhoneNo": phonenumber,
                          "Email": emailID,
                          "Address": address,
                        });
                        customerNamecontroller.text = '';
                        customerPhonenocontroller.text = '';
                        customerEmailcontroller.text = '';
                        customerAddresscontroller.text = '';
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

    // ignore: non_constant_identifier_names
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
        title: Text(
            // ignore: avoid_function_literals_in_foreach_calls
            '${FirebaseFirestore.instance.collection("/Customer").where("Status", isEqualTo: "active").get().then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
                  // ignore: avoid_print, prefer_interpolation_to_compose_strings
                  print("dcument Id " + element.data().toString());
                }))}'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("/Customer").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return InkWell(
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['Name']),
                      subtitle: Text(documentSnapshot['Email']),
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
                    ),
                  ),
                  onTap: () {
                    Get.offAndToNamed("/custinfo");
                  },
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
