import 'package:flutter/material.dart';

String? payUrl;
String? payResult;
String? tokenUser;
int? payAddMoney;
const kToken = 'token';
const String baseurl = 'https://accept.paymob.com/api/';
//first token url
const String authenticationrequesturl =
    'https://accept.paymob.com/api/auth/tokens';
const String CheckOrderRequesturl =
    'https://accept.paymob.com/api/acceptance/transactions';
const String orderidurl = 'https://accept.paymob.com/api/ecommerce/orders';
const String paymentkeytokenurl =
    'https://accept.paymob.com/api/acceptance/payment_keys';
const String paymentReferencecodeurl =
    'https://accept.paymob.com/api/acceptance/payments/pay';

String paymentApiKey =
    'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RnMk9UWXhMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuZWxRYWR5ZE13Z3ZVTm92MW54RFVSSlpHVUdDVW9FZmEwWDhzNGtia2RVcVdoZmV6MFhpZTN4NFVvbGpXSXlEQUFhaUlYRWNKNXgxMFliSEZKVDRBdkE=';
//card
//'2888691'
int integrationIDCard = 4617788;
//683693
int iframeIdCard = 858046;
// 777228
String iframeIdValu = '777228';
String? orderIdCard;

// '4061071'
String? integrationIDValu;
// '2913773'
String? integrationIDWallet;

//kiosk
const String integrationIDKiosk = '2083380';
String paymentFirstToken = '';
String paymentOrderId = '';
String finalToken = '';
String refcode = '';
String iframeRedirectionUrl = '';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);
// showdialog(context, String text, Color color, {double? fontsize = 16}) {
//   return showFlash(
//       duration: const Duration(seconds: 5),
//       context: context,
//       builder: (context, controller) {
//         return Flash(
//             // alignment: Alignment.bottomCenter,
//             // margin: const EdgeInsets.only(bottom: 70),
//             // backgroundColor: color,
//             // borderRadius: BorderRadius.circular(20),
//             controller: controller,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.info_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       text,
//                       maxLines: 1,
//                       style: TextStyle(color: Colors.white, fontSize: fontsize),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       });
// }
