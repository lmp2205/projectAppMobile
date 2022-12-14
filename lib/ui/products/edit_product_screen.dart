import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../shared/dialog_utils.dart';
import 'products_manager.dart';


class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        description: '',
        imageUrl:
            '',
        laisuat: 2,
        name: '',
        phone: 0,
        cmnd: '',
        type: '',
        plate: '',
        date: DateTime.now(),
        kyhan: 30,
        // enddate: 30,
      );
    } else {
      this.product = product;
    }
  }

  late final Product product;
  

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;
  final TextEditingController _date = TextEditingController();
  DateTime dateTime = DateTime.now();
    late final Product product;


  File? _image;
  bool _uploading = false;
  final picker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('khong co');
      }
    });
  }

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
  }

  bool _isValidimageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidimageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildPriceField(),
                    buildName(),
                    buildPhone(),
                    buildCMND(),
                    buildType(),
                    buildPlate(),
                    buildDate(),
                    buildKyhan(),
                    buildLaisuat(),
                    buildProductPreview(),
                    buildDescriptionField(),
                    // selectImage(),
                    // Saveimage(),
                  ],
                ),
              ),
            ),
    );
  }



  Container buildTitleField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: _editedProduct.title,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'T??n V???t K?? G???i',
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'B???n ch??a ??i???n t??n';
          }
           return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(title: value);
        },
      ),
    );
  }

  // Future<String> uploadFile() async {
  //     File file = File(_image!.path);
  //     String imageName = 'productImage/${DateTime.now().microsecondsSinceEpoch}';
  //     String downloadUrl = '';
  //     try {
  //       await FirebaseStorage.instance
  //           .ref(imageName)
  //           .putFile(file);
  //           downloadUrl = await FirebaseStorage.instance
  //           .ref(imageName)
  //           .getDownloadURL();
  //           if(downloadUrl != null){
  //             _image = null;
  //             print(downloadUrl);
  //           }
  //     } on FirebaseException catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Cancalled"),
  //         ),
  //       );
  //     }
  //     return downloadUrl;
  //   }

  Container buildName() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: _editedProduct.name,
        decoration: const InputDecoration(
          labelText: 'H??? T??n Ng?????i K?? G???i',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'B???n ch??a ??i???n t??n';
          }
           return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(name: value);
        },
      ),
    );
  }

  Container buildCMND() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: _editedProduct.cmnd,
        decoration: const InputDecoration(
          labelText: 'Ch???ng minh nh??n d??n',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {},
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(cmnd: value);
        },
      ),
    );
  }

  Container buildType() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: _editedProduct.type,
        decoration: const InputDecoration(
          labelText: 'Ph??n Lo???i',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui long ch???n ph??n lo???i';
          }
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(type: value);
        },
      ),
    );
  }

  Container buildPlate() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: _editedProduct.plate,
        decoration: const InputDecoration(
          labelText: 'M?? Hi???u/Bi???n S???',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(plate: value);
        },
      ),
    );
  }



  Widget buildDate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue:  null,
        controller: _date,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Ng??y C???m',
          icon: Icon(Icons.calendar_today_rounded),
        ),
        onTap: () async {
          final currentDate = DateTime.now();
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(2022),
            lastDate: currentDate,
          );
          if (selectedDate != null) {
            setState(() {
              if (selectedDate != null) {
                dateTime = selectedDate;
                _date.text = DateFormat('yyyy-MM-dd').format(selectedDate);
              }
            });
          }
        },
        validator: (value) {
          return null;
        },
        autofocus: true,
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(date: dateTime);
        },
      ),
    );
  }

  Container buildPhone() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
          initialValue: _editedProduct.phone.toString(),
          decoration: const InputDecoration(
            labelText: 'S??T',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'B???n ch??a nh???p s??? ??i???n tho???i';
            }
            if (value.length < 8) {
              return 'S??T Kh??ng h???p l???';
            }
            if (value.length > 12) {
              return 'S??T Kh??ng h???p l???';
            }
            return null;
          },
          onSaved: (value) {
            _editedProduct = _editedProduct.copyWith(phone: int.parse(value!));
          }),
    );
  }

  Container buildKyhan() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
          initialValue: _editedProduct.kyhan.toString(),
          decoration: const InputDecoration(
            labelText: 'K??? H???n',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          onSaved: (value) {
            _editedProduct =
                _editedProduct.copyWith(kyhan: double.parse(value!));
          }),
    );
  }

  Container buildPriceField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
          initialValue: _editedProduct.price.toString(),
          decoration: const InputDecoration(
            labelText: 'S??? ti???n',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'B???n nh???p s??? ti???n.';
            }
            if (double.tryParse(value) == null) {
              return 'S??? ti???n kh??c 0';
            }
            if (double.parse(value) <= 0) {
              return 'S??? ti???n l???n h??n 0';
            }
            return null;
          },
          onSaved: (value) {
            _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
          }),
    );
  }

  Container buildLaisuat() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
          initialValue: _editedProduct.laisuat.toString(),
          decoration: const InputDecoration(
            labelText: 'L??i su???t',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ch??a nh???p l??i su???t';
            }
            if (double.tryParse(value) == null) {
              return 'Ch??a nh???p l??i su???t';
            }
            if (double.parse(value) <= 0) {
              return 'N?? ph???i l???n h??n 0 c??';
            }
            return null;
          },
          onSaved: (value) {
            _editedProduct =
                _editedProduct.copyWith(laisuat: double.parse(value!));
          }),
    );
  }

  Container buildDescriptionField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
          initialValue: _editedProduct.description,
          decoration: const InputDecoration(
            labelText: 'Ghi Ch??',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          validator: (value) {
            return null;
          },
          onSaved: (value) {
            _editedProduct = _editedProduct.copyWith(description: value);
          }),
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(
              top: 8,
              right: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: _imageUrlController.text.isEmpty
                ? const Text('Nh???p link')
                : FittedBox(
                    child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ))),
        Expanded(
          child: buildimageUrlField(),
        ),
      ],
    );
  }

  TextFormField buildimageUrlField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nh???p link',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.done,
        controller: _imageUrlController,
        focusNode: _imageUrlFocusNode,
        onFieldSubmitted: (value) => _saveForm(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Nh???p link h??nh ???nh';
          }
          if (!_isValidimageUrl(value)) {
            return 'Link kh??ng h???p l???';
          }
          return null;
        },
        onSaved: (value) {
          _editedProduct = _editedProduct.copyWith(imageUrl: value);
        });
  }
  // ElevatedButton selectImage() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       pickImage(ImageSource.gallery);

  //     },
  //     child: Text('Chon'),
  //   );
  // }

  // ElevatedButton Saveimage() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       setState(() {
  //         _uploading = true;
  //        uploadFile().then((url) {
  //         if (url != null){
  //           setState (){
  //             _uploading = false;
  //           }
  //         }
  //        });
  //       });
  //     },
  //     child: Text('save'),
  //   );
  // }
}
