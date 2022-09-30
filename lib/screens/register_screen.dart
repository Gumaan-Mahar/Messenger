import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:messenger/controllers/register_screen_controller.dart';
import 'package:messenger/services/auth_services.dart';
import 'package:messenger/utils/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterScreenController _registerScreenController =
      Get.put(RegisterScreenController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                SvgPicture.asset(
                  'assets/images/Logo.svg',
                  alignment: Alignment.centerRight,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Text(
                  'Phone Number'.tr,
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Add phone number to register'.tr,
                  style: context.theme.textTheme.labelLarge!.copyWith(
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.12,
                ),
                SizedBox(
                  width: Get.width * 0.85,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              _registerScreenController.textEditingController,
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          maxLength: 15,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            label:  Text('Phone Number'.tr),
                            fillColor: Colors.transparent,
                            counterText: '',
                            prefix: Padding(
                              padding: EdgeInsets.only(right: Get.width * 0.02),
                              child: Obx(
                                () => Text(
                                  '+${_registerScreenController.selectedCountryCode.value}',
                                ),
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      flagSize: 25,
                                      backgroundColor:
                                          Get.theme.scaffoldBackgroundColor,
                                      textStyle: const TextStyle(
                                          fontSize: 16, color: Colors.blueGrey),
                                      bottomSheetHeight:
                                          500, // Optional. Country list modal height
                                      //Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
    
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search'.tr,
                                        hintText: 'Start typing to search'.tr,
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelect: (country) {
                                      _registerScreenController
                                          .selectedCountryCode
                                          .value = country.phoneCode;
                                    });
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                            floatingLabelStyle: Get.theme.textTheme.labelLarge!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone number is required'.tr;
                            } else if (!value.isNumericOnly) {
                              return 'Only digits are allowed';
                            } else if (value.length < 5 && value.isNotEmpty) {
                              return 'Phone number is too short'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              AuthServices.verifyPhoneNumber(
                                  phoneNumber:
                                      '+${_registerScreenController.selectedCountryCode.value}${_registerScreenController.textEditingController.text}');
                            }
                          },
                          child: Text(
                            'CONFIRM'.tr,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
