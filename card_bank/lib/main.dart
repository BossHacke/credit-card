import 'package:card_bank/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController bankName = TextEditingController();

  @override
  void initState() {
    super.initState();
    bankName = TextEditingController(text: "");
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black12,
        title: Center(
          child: Text(
            'Credit Card',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.bg.provider(),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CreditCardWidget(
                //spell:ignore glassmorphismConfig Glassmorphism
                glassmorphismConfig: Glassmorphism.defaultConfig(),
                enableFloatingCard: true,
                floatingConfig: FloatingConfig(
                  isGlareEnabled: true,
                  isShadowEnabled: true,
                  shadowConfig: FloatingShadowConfig(
                    offset: Offset(10, 10),
                    color: Colors.black87,
                    blurRadius: 15,
                  ),
                ),
                bankName: bankName.text,
                backgroundImage: 'assets/images/card_bg.png',
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                frontCardBorder: Border.all(color: Colors.grey),
                backCardBorder: Border.all(color: Colors.grey),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.black,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: [
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image(
                      image: Assets.images.mastercard.provider(),
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17, right: 17, top: 20),
                          child: TextFormField(
                            controller: bankName,
                            style: const TextStyle(color: Colors.white),
                            onEditingComplete: (() => setState(() {})),
                            decoration: InputDecoration(
                              labelText: 'Bank Name',
                              hintText: 'Name',
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                            ),
                          ),
                        ),
                        CreditCardForm(
                          formKey: formKey,
                          // autovalidateMode: AutovalidateMode.onUnfocus,
                          cvvValidationMessage: 'Please input a valid CVV',
                          dateValidationMessage: 'Please input a valid date',
                          numberValidationMessage:
                              'Please input a valid number',
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          onCreditCardModelChange: onCreditCardModelChange,
                          //spell:ignore autovalidateMode
                          inputConfiguration: const InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Card Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                            ),
                            expiryDateDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              labelText: 'Card Holder',
                            ),
                            cardNumberTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            cardHolderTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            expiryDateTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            cvvCodeTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _onValidate,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Colors.purple,
                                  Colors.amber,
                                  Colors.blue
                                ],
                                begin: Alignment(-1, -4),
                                end: Alignment(1, 4),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text(
                              'Success',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                        ),
                      ],
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

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      //spell:ignore thêm thành công
      _showValidDialog(
          context, "Hợp lệ", "Thẻ của bạn hợp lệ thêm thành công !!!");
    } else {
      //spell:ignore Không
      _showValidDialog(context, "Không hợp lệ", "Thử lại !!!");
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(content),
          actions: [
            Builder(
              builder: (_) => ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
