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
          labelText: 'Tên Vật Ký Gửi',
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Bạn chưa điền tên';
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
          labelText: 'Họ Tên Người Ký Gửi',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Bạn chưa điền tên';
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
          labelText: 'Chứng minh nhân dân',
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
          labelText: 'Phân Loại',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui long chọn phân loại';
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
          labelText: 'Mã Hiệu/Biển Số',
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
          labelText: 'Ngày Cầm',
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
            labelText: 'SĐT',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Bạn chưa nhập số điện thoại';
            }
            if (value.length < 8) {
              return 'SĐT Không hợp lệ';
            }
            if (value.length > 12) {
              return 'SĐT Không hợp lệ';
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
            labelText: 'Kỳ Hạn',
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
            labelText: 'Số tiền',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Bạn nhập số tiền.';
            }
            if (double.tryParse(value) == null) {
              return 'Số tiền khác 0';
            }
            if (double.parse(value) <= 0) {
              return 'Số tiền lớn hơn 0';
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
            labelText: 'Lãi suất',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Chưa nhập lãi suất';
            }
            if (double.tryParse(value) == null) {
              return 'Chưa nhập lãi suất';
            }
            if (double.parse(value) <= 0) {
              return 'Nó phải lớn hơn 0 cơ';
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
            labelText: 'Ghi Chú',
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
                ? const Text('Nhập link')
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
          labelText: 'Nhập link',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.done,
        controller: _imageUrlController,
        focusNode: _imageUrlFocusNode,
        onFieldSubmitted: (value) => _saveForm(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Nhập link hình ảnh';
          }
          if (!_isValidimageUrl(value)) {
            return 'Link không hợp lệ';
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
