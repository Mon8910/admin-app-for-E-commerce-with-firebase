import 'dart:io';

import 'package:admin_app/constants/app_constants.dart';
import 'package:admin_app/constants/my_validator.dart';
import 'package:admin_app/models/product_model.dart';
import 'package:admin_app/services/my_app_method.dart';
import 'package:admin_app/widgets/subtitle_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditOrUpdateScreen extends StatefulWidget {
  const EditOrUpdateScreen({
    super.key,
    this.productModel,
  });
  final ProductModel? productModel;

  @override
  State<EditOrUpdateScreen> createState() => _EditOrUpdateScreen();
}

class _EditOrUpdateScreen extends State<EditOrUpdateScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleProduct;
  late TextEditingController priceProduct;
  late TextEditingController qtyProduct;
  late TextEditingController descriptionProduct;
  bool isLoading = false;
  XFile? pickedImage;
  String? _categoryvalue;
  String? productNetworkImage;
  bool isEditing = false;
  String? imageUrl;
  @override
  void dispose() {
    titleProduct.dispose();
    priceProduct.dispose();
    qtyProduct.dispose();
    descriptionProduct.dispose();
    super.dispose();
  }

  Future<void> _editProduct() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_categoryvalue == null) {
      MyAppMthods.showErrorWringDialog(
        context: context,
        fun: () {},
        title: 'choose your category',
      );
      return;
    }
    if (isValid) {
      formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        if (pickedImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('productImage')
              .child('${titleProduct.text.trim()}.jpg');
          await ref.putFile(
            File(pickedImage!.path),
          );
          imageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productModel!.productId)
            .update({
          'userId': widget.productModel!.productId,
          'userImage': imageUrl ?? productNetworkImage,
          'titleProduct': titleProduct.text,
          'priceProduct': priceProduct.text,
          'qtyProduct': qtyProduct.text,
          'descriptionProduct': descriptionProduct.text,
          'createdAt': widget.productModel!.createdAt,
          'category': _categoryvalue
        });
        Fluttertoast.showToast(
          msg: "the product has been updated ",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
            context: context,
            fun: () {
              clearForm();
            },
            title: 'clear Data',
            isError: false);
      } on FirebaseException catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured ${error.message}',
        );
      } catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured$error',
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  checkValidate() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null) {
      MyAppMthods.showErrorWringDialog(
          context: context, fun: () {}, title: 'Make sure to pick image');
      return;
    }
    if (_categoryvalue == null) {
      MyAppMthods.showErrorWringDialog(
          context: context, fun: () {}, title: 'choose your category');
      return;
    }
    if (isValid) {
      formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('productImage')
            .child('${titleProduct.text.trim()}.jpg');
        await ref.putFile(
          File(pickedImage!.path),
        );
        imageUrl = await ref.getDownloadURL();
        final uid = const Uuid().v4();

        await FirebaseFirestore.instance.collection('products').doc(uid).set({
          'userId': uid,
          'userImage': imageUrl,
          'titleProduct': titleProduct.text,
          'priceProduct': priceProduct.text,
          'qtyProduct': qtyProduct.text,
          'descriptionProduct': descriptionProduct.text,
          'createdAt': Timestamp.now(),
          'category': _categoryvalue
        });
        Fluttertoast.showToast(
          msg: "the email has been created ",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
            context: context,
            fun: () {
              clearForm();
            },
            title: 'clear Data',
            isError: false);
      } on FirebaseException catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured ${error.message}',
        );
      } catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured$error',
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void removePickedImage() {
    setState(() {
      pickedImage = null;
      productNetworkImage = null;
    });
  }

  void clearForm() {
    titleProduct.clear();
    priceProduct.clear();
    qtyProduct.clear();
    descriptionProduct.clear();
    removePickedImage();
    _categoryvalue = null;
  }

  pickimage() {
    final ImagePicker picker = ImagePicker();
    MyAppMthods.pickImage(
        context: context,
        funCamera: () async {
          pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {
            imageUrl = null;
          });
        },
        funGallery: () async {
          pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {
            imageUrl = null;
          });
        },
        funRemove: () {
          setState(() {
            pickedImage = null;
          });
        });
  }

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      _categoryvalue = widget.productModel!.productCategory;
    }
    titleProduct =
        TextEditingController(text: widget.productModel?.productTitle);
    priceProduct =
        TextEditingController(text: widget.productModel?.productPrice);
    qtyProduct =
        TextEditingController(text: widget.productModel?.productQuantity);
    descriptionProduct =
        TextEditingController(text: widget.productModel?.productDescription);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  clearForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.clear),
                label: const Text('Clear'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (isEditing) {
                    _editProduct();
                  } else {
                    checkValidate();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.upload),
                label: Text(isEditing ? 'edit product' : 'Upload Producrt'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const SubtitleText(label: 'Add a New Product'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isEditing && productNetworkImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      productNetworkImage!,
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ] else if (pickedImage == null) ...[
                  SizedBox(
                    width: size.width * 0.4 + 10,
                    height: size.width * 0.4,
                    child: DottedBorder(
                        color: Colors.blue,
                        radius: const Radius.circular(12),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image_outlined,
                                size: 80,
                                color: Colors.blue,
                              ),
                              TextButton(
                                onPressed: () {
                                  pickimage();
                                },
                                child: const Text("Pick Product image"),
                              ),
                            ],
                          ),
                        )),
                  )
                ] else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(
                        pickedImage!.path,
                      ),
                      // width: size.width * 0.7,
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
                if (pickedImage != null || productNetworkImage != null) ...[
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      onPressed: () {
                        pickimage();
                      },
                      child: const Text("Pick another image"),
                    ),
                    TextButton(
                      onPressed: () {
                        removePickedImage();
                      },
                      child: const Text(
                        "Remove image",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ])
                ],
                const SizedBox(
                  height: 40,
                ),
                DropdownButton(
                    hint: const Text('Select your category'),
                    items: AppConstants.items,
                    value: _categoryvalue,
                    onChanged: (String? value) {
                      setState(() {
                        _categoryvalue = value;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleProduct,
                  maxLines: 1,
                  maxLength: 80,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(hintText: 'Product Title'),
                  validator: (value) {
                    return MyValidators.uploadProdTexts(
                        value: value,
                        toBeReturnedString: 'please enter the valid product');
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: priceProduct,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: 'Product price'),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString:
                                  'please enter the valid price');
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: qtyProduct,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: 'Product qunatity'),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString:
                                  'please enter the valid qunatity');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                TextFormField(
                  controller: descriptionProduct,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(hintText: 'Product description'),
                  validator: (value) {
                    return MyValidators.uploadProdTexts(
                        value: value,
                        toBeReturnedString:
                            'please enter the valid description');
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
