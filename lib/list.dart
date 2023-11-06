import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListAdd extends StatefulWidget {
  const ListAdd({super.key});

  @override
  State<ListAdd> createState() => _ListAddState();
}

class _ListAddState extends State<ListAdd> {
  final CollectionReference _products = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
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
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final double? price = double.parse(_priceController.text);
                      if (price != null) {
                        await _products
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "price": price});
                        _nameController.text = '';
                        _priceController.text = '';
                      }
                    },
                    child: const Text('Upadate'),
                  )
                ],
              ));
        });
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price = double.parse(_priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Succesfully deleted a product")));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("FirebaseCRUD"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black45,
          onPressed: () => _create(),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder(
            //helps to keep persistent connection with firestore database
            stream: _products.snapshots(), //build connection
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              //streamSnapshot have all data avail in db
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length, //no of rows
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot
                              .data!.docs[
                          index]; //refer to the rows we will able to acees the column or feilds
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Text(documentSnapshot['name'],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(documentSnapshot['price'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _update(documentSnapshot),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _delete(documentSnapshot.id),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
