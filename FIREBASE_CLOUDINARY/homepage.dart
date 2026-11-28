
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import 'login_page.dart';
import 'crud_server.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CrudService service = CrudService();

  final TextEditingController nameCtrl =
      TextEditingController();

  final TextEditingController qtyCtrl =
      TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    qtyCtrl.dispose();
    super.dispose();
  }

  // LOGOUT
  Future<void> logout() async {
    await AuthService().signOut();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
    );
  }

  // ADD ITEM DIALOG
  void openAddDialog() {
    nameCtrl.clear();
    qtyCtrl.clear();

    String? selectedImageUrl;
    bool uploading = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Item'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: qtyCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // IMAGE PREVIEW
                    if (selectedImageUrl != null)
                      Image.network(
                        selectedImageUrl!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),

                    const SizedBox(height: 10),

                    // UPLOAD IMAGE
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: const Text('Select Image'),

                      onPressed: uploading
                          ? null
                          : () async {
                              setDialogState(() {
                                uploading = true;
                              });

                              try {
                                final pickedImage =
                                    await service.pickImageForAddItem();

                                if (pickedImage != null) {
                                  setDialogState(() {
                                    selectedImageUrl =
                                        pickedImage.url;
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Image upload failed: $e',
                                    ),
                                  ),
                                );
                              } finally {
                                setDialogState(() {
                                  uploading = false;
                                });
                              }
                            },
                    ),

                    if (uploading)
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),

              actions: [
                // CANCEL BUTTON
                TextButton(
                  onPressed: uploading
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                        },
                  child: const Text('Cancel'),
                ),

                // SAVE BUTTON
                ElevatedButton(
                  onPressed: uploading
                      ? null
                      : () async {
                          if (nameCtrl.text.trim().isEmpty ||
                              qtyCtrl.text.trim().isEmpty) {
                            return;
                          }

                          final quantity =
                              int.tryParse(qtyCtrl.text.trim());

                          if (quantity == null) {
                            return;
                          }

                          try {
                            await service.addItemWithImage(
                              nameCtrl.text.trim(),
                              quantity,
                              selectedImageUrl,
                            );

                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to save item: $e',
                                ),
                              ),
                            );
                          }
                        },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // EDIT ITEM DIALOG
  void openEditDialog(
    String id,
    String currentName,
    int currentQuantity,
  ) {
    nameCtrl.text = currentName;
    qtyCtrl.text = currentQuantity.toString();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Item'),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            child: const Text('Update'),

            onPressed: () async {
              final quantity =
                  int.tryParse(qtyCtrl.text.trim());

              if (nameCtrl.text.trim().isEmpty ||
                  quantity == null) {
                return;
              }

              await service.updateItem(
                id,
                nameCtrl.text.trim(),
                quantity,
              );

              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
              }
            },
          ),
        ],
      ),
    );
  }

  // DELETE ITEM
  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Item'),

        content: const Text(
          'Are you sure you want to delete this item?',
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),

            onPressed: () async {
              await service.deleteItem(id);

              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
              }
            },

            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,

      appBar: AppBar(
        title: const Text('Firebase | GIVERA'),
        centerTitle: true,
        backgroundColor: Colors.teal,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),

      // DISPLAY FIRESTORE ITEMS
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getItems(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No items found. Add your first item!',
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder: (context, index) {
              final item = docs[index];
              final data =
                  item.data() as Map<String, dynamic>;

              final imageUrl = data['image_url'];
              final name = data['name'] ?? '';
              final quantity = data['quantity'] ?? 0;

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: ListTile(
                  // DISPLAY CLOUDINARY IMAGE
                  leading: imageUrl != null &&
                          imageUrl.toString().isNotEmpty
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 45,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          size: 45,
                        ),

                  title: Text(name.toString()),

                  subtitle: Text(
                    'Quantity: $quantity',
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),

                        onPressed: () {
                          openEditDialog(
                            item.id,
                            name.toString(),
                            (quantity as num).toInt(),
                          );
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                        onPressed: () {
                          confirmDelete(item.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // ADD ITEM BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
