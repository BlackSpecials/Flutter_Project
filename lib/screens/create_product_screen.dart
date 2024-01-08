import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  int _quantity = 0;
  double _price = 0.0;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageController.text = pickedFile.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 0) {
                        _quantity--;
                      }
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 8),
                Text('$_quantity'),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  _price = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text("Select Image"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveProduct();
              },
              child: Text("Save Product"),
            ),
          ],
        ),
      ),
    );
  }

  void saveProduct() {
    String name = _nameController.text;
    String category = _categoryController.text;
    int quantity = _quantity;
    double price = _price;
    String image = _imageController.text;
    String description = _descriptionController.text;


    _nameController.clear();
    _categoryController.clear();
    _quantity = 0;
    _price = 0.0;
    _imageController.clear();
    _descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product saved successfully!'),
      ),
    );
  }
}
