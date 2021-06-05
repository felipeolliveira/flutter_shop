import 'package:flutter/material.dart';

class ProductManagerFormPage extends StatefulWidget {
  @override
  _ProductManagerFormPageState createState() => _ProductManagerFormPageState();
}

class _ProductManagerFormPageState extends State<ProductManagerFormPage> {
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

  void _updateImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url da Imagem'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                focusNode: _imageUrlFocus,
                controller: _imageUrlController,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Chip(
                      label: Text(
                        _imageUrlController.text.isEmpty
                            ? 'Informa uma URL'
                            : 'Preview',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: _imageUrlController.text.isEmpty
                          ? Theme.of(context).errorColor
                          : Theme.of(context).primaryColor,
                    ),
                    if (_imageUrlController.text.isNotEmpty)
                      FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _imageUrlController.text,
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
