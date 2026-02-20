import 'package:flexedu/core/paymob/const.dart';
import 'package:paymob_payment/paymob_payment.dart';

class PayMobIntegration {
  static Future intialize() async {
    PaymobPayment.instance.initialize(
      apiKey:
          paymentApiKey, // from dashboard Select Settings -> Account Info -> API Key
      integrationID:
          integrationIDCard, // from dashboard Select Developers -> Payment Integrations -> Online Card ID
      iFrameID: iframeIdCard, // from paymob Select Developers -> iframes
    );
  }
}
