import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/input_validator.dart';

class ProductManagerFormPage extends StatefulWidget {
  @override
  _ProductManagerFormPageState createState() => _ProductManagerFormPageState();
}

class _ProductManagerFormPageState extends State<ProductManagerFormPage> {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      } else {
        _formData['price'] = '';
      }
    }
  }

  void _updateImage() {
    print(_imageUrlController.text);
    print(InputValidator.url(_imageUrlController.text));

    if (InputValidator.url(_imageUrlController.text) == null) {
      setState(() {});
    }
  }

  void _saveForm() {
    bool isValide = _form.currentState.validate();

    if (!isValide) {
      return;
    }

    _form.currentState.save();

    final Product product = Product(
      id: _formData['id'],
      description: _formData['description'],
      title: _formData['title'],
      imageUrl: _formData['imageUrl'],
      price: _formData['price'],
    );

    final products = Provider.of<ProductsProvider>(context, listen: false);

    if (_formData['id'] == null) {
      products.addProduct(product);
    } else {
      products.updateProduct(product);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alteração'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['title'] = value,
                validator: (value) {
                  return InputValidator.title(value);
                },
              ),
              TextFormField(
                initialValue: _formData['price'].toString(),
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['price'] = double.parse(value),
                validator: (value) {
                  return InputValidator.price(value);
                },
              ),
              TextFormField(
                initialValue: _formData['description'],
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _formData['description'] = value,
                validator: (value) {
                  return InputValidator.description(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url da Imagem'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                focusNode: _imageUrlFocus,
                controller: _imageUrlController,
                onSaved: (value) => _formData['imageUrl'] = value,
                validator: (value) {
                  return InputValidator.url(value);
                },
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Chip(
                      label: Text(
                        _imageUrlController.text.isEmpty
                            ? 'Preview: informe uma URL válida'
                            : 'Preview',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: _imageUrlController.text.isEmpty
                          ? Theme.of(context).errorColor
                          : Theme.of(context).primaryColor,
                    ),
                    if (_imageUrlController.text.isNotEmpty)
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
