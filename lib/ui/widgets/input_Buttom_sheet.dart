import 'package:flutter/material.dart';
import 'package:sales/ui/data/firbase_store/sales_items.dart';
import 'package:sales/ui/data/validator/custom_validator.dart';
import 'package:sales/ui/widgets/custom_elevated_button.dart';
import 'package:sales/ui/widgets/custom_text_form_field.dart';

class InputButtomSheet extends StatefulWidget {
  const InputButtomSheet({super.key});

  @override
  State<InputButtomSheet> createState() => _InputButtomSheetState();
}

class _InputButtomSheetState extends State<InputButtomSheet> {
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  var submitKey = GlobalKey<FormState>();
  String? imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: submitKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
                controller: productNameController,
                hintText: 'product name',
                keyboardType: TextInputType.name,
                validator: CustomValidator.productNameValidator),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: productPriceController,
              hintText: 'product price',
              keyboardType: TextInputType.number,
              validator: (value) {
                return CustomValidator.productNameValidator(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () async {
                imageUrl = await Salesitems.uploadImage();
                setState(() {});
              },
              icon: const Icon(
                Icons.camera_alt,
                size: 30,
              ),
            ),
            if (imageUrl != '')
              Image.network(
                imageUrl!,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/errorImage.jpg');
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  onPressed: () async {
                    if (submitKey.currentState!.validate()) {
                      await Salesitems.submitItem(
                          productName: productNameController.text,
                          productPrice:
                              double.tryParse(productPriceController.text),
                          productImage: imageUrl);
                      Navigator.pop(context);
                    }
                  },
                  textButton: 'submit',
                  backgroundColor: Colors.green,
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textButton: 'cancel',
                  backgroundColor: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
