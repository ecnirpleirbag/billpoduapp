import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProductListscreen extends StatelessWidget {
  const ProductListscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController productnameController = TextEditingController();
    TextEditingController productpriceController = TextEditingController();
    TextEditingController productqntyController = TextEditingController();

    Future<void> update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        productnameController.text = documentSnapshot['name'];
        productpriceController.text = documentSnapshot['price'];
        productqntyController.text = documentSnapshot['quantity'];
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
                    controller: productnameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: productpriceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  TextField(
                    controller: productqntyController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String name = productnameController.text;
                      final double? price =
                          double.tryParse(productpriceController.text);
                      final double? quantity =
                          double.tryParse(productqntyController.text);
                      // ignore: unnecessary_null_comparison
                      if (name != null) {
                        await FirebaseFirestore.instance
                            .collection('/Products')
                            .doc(documentSnapshot!.id)
                            .update({
                          "name": name,
                          "price": price,
                          "quantity": quantity,
                        });
                        productnameController.text = '';
                        productpriceController.text = '';
                        productqntyController.text = '';
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
    Future<void> delete(String ProductID) async {
      await FirebaseFirestore.instance
          .collection("/Products")
          .doc(ProductID)
          .delete();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have successfully deleted a product'),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
        ),
        bottomNavigationBar: GNav(
          gap: 5,
          haptic: true,
          tabs: [
            GButton(
              onPressed: () {
                Get.toNamed("/home");
              },
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              onPressed: () {
                Get.toNamed("/customer");
              },
              icon: Icons.person_add,
              text: 'customer',
            ),
            GButton(
              onPressed: () {
                Get.toNamed("/product");
              },
              icon: Icons.shopping_basket,
              text: 'product',
            ),
            GButton(
              onPressed: () {
                Get.toNamed("/profile");
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
                controller: productnameController,
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: productpriceController,
                decoration: const InputDecoration(
                  labelText: 'Product price',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: productqntyController,
                decoration: const InputDecoration(
                  labelText: 'Product quantity',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> product = {
                        "name": productnameController.text,
                        "price": productpriceController.text,
                        "quantity": productqntyController.text,
                      };
                      FirebaseFirestore.instance
                          .collection("Products")
                          .add(product)
                          .then((value) {
                        Navigator.of(context).pushNamed('/product');
                      });
                    },
                    child: const Text('Add'),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show All Product'),
                  ),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("/Products")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                            title: Text(documentSnapshot['name']),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(children: [
                                IconButton(
                                  onPressed: () => update(documentSnapshot),
                                  icon: const Icon(Icons.edit),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          delete(documentSnapshot.id),
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
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
        ));
  }
}
