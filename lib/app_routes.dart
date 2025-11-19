import 'package:flutter/material.dart';
import 'package:go_bank/main_scaffold.dart';
import 'package:go_bank/screens/account_number_screen.dart';
import 'package:go_bank/screens/airtime_amount_screen.dart';
import 'package:go_bank/screens/airtime_confirm_screen.dart';
import 'package:go_bank/screens/airtime_phone_screen.dart';
import 'package:go_bank/screens/airtime_provider_screen.dart';
import 'package:go_bank/screens/airtime_purchase_screen.dart';
import 'package:go_bank/screens/airtime_success_screen.dart';

import 'package:go_bank/screens/bills_category_screen.dart';
import 'package:go_bank/screens/bills_confirm_screen.dart';
import 'package:go_bank/screens/bills_package_screen.dart';
import 'package:go_bank/screens/bills_provider_screen.dart';
import 'package:go_bank/screens/bills_smartcard_screen.dart';
import 'package:go_bank/screens/bills_success_screen.dart';
import 'package:go_bank/screens/confirm_details_screen.dart';
import 'package:go_bank/screens/data_page.dart';
import 'package:go_bank/screens/data_confirm_screen.dart';
import 'package:go_bank/screens/data_package_screen.dart';
import 'package:go_bank/screens/data_phone_screen.dart';
import 'package:go_bank/screens/data_provider_screen.dart';
import 'package:go_bank/screens/data_success_screen.dart';
import 'package:go_bank/screens/enter_account_details_screen.dart';
import 'package:go_bank/screens/enter_account_number_screen.dart';
import 'package:go_bank/screens/enter_pin_screen.dart';
import 'package:go_bank/screens/enter_transfer_amount_screen.dart';
import 'package:go_bank/screens/login_screen.dart';
import 'package:go_bank/screens/more_services_screen.dart';
import 'package:go_bank/screens/notifications_screen.dart';
import 'package:go_bank/screens/onboarding_screen.dart';
import 'package:go_bank/screens/pay_bills_screen.dart';
import 'package:go_bank/screens/profile_details_screen.dart';
import 'package:go_bank/screens/send_to_bank_screen.dart';
import 'package:go_bank/screens/sign_up_screen.dart';
import 'package:go_bank/screens/splash_screen.dart';
import 'package:go_bank/screens/transaction_history_screen.dart';
import 'package:go_bank/screens/transaction_successful_screen.dart';
import 'package:go_bank/screens/transfer_choice_screen.dart';
import 'package:go_bank/screens/select_network_page.dart';
import 'package:go_bank/screens/welcome_screen.dart';
import 'package:go_bank/screens/select_bank_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String finance = '/finance';
  static const String cards = '/cards';
  static const String profile = '/profile';
  static const String transferChoice = '/transfer-choice';
  static const String sendToBank = '/send-to-bank';
  static const String bankSelection = '/bank-selection';
  static const String selectBank = '/select-bank';
  static const String enterAccountNumber = '/enter-account-number';
  static const String enterAccountDetails = '/enter-account-details';
  static const String enterTransferAmount = '/enter-transfer-amount';
  static const String accountNumber = '/account-number';

  static const String confirmDetails = '/transfer-confirm';
  static const String pin = '/pin';
  static const String transferSuccess = '/transfer-success';
  static const String airtimePurchase = '/airtime-purchase';
  static const String airtimeProvider = '/airtime-provider';
  static const String airtimePhone = '/airtime-phone';
  static const String airtimeAmount = '/airtime-amount';
  static const String airtimeConfirm = '/airtime-confirm';
  static const String airtimeSuccess = '/airtime-success';
  static const String dataPage = '/data-page';
  static const String dataProvider = '/data-provider';
  static const String dataPackage = '/data-package';
  static const String dataPhone = '/data-phone';
  static const String dataConfirm = '/data-confirm';
  static const String dataSuccess = '/data-success';
  static const String billsCategory = '/bills-category';
  static const String billsProvider = '/bills-provider';
  static const String billsPackage = '/bills-package';
  static const String billsSmartcard = '/bills-smartcard';
  static const String billsConfirm = '/bills-confirm';
  static const String billsSuccess = '/bills-success';
  static const String notifications = '/notifications';
  static const String moreServices = '/more-services';
  static const String transactionHistory = '/transaction-history';
  static const String profileDetails = '/profile-details';
  static const String payBills = '/pay-bills';
  static const String selectNetwork = '/select-network';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 0));
      case finance:
        return MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 1));
      case cards:
        return MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 2));
      case profile:
        return MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 3));
      case transferChoice:
        return MaterialPageRoute(builder: (context) => const TransferChoiceScreen());
      case sendToBank:
        return MaterialPageRoute(builder: (context) => const SendToBankScreen());
      case bankSelection:
        return MaterialPageRoute(builder: (context) => const SelectBankScreen());
      case selectBank:
        return MaterialPageRoute(builder: (context) => const SelectBankScreen());
      case enterAccountNumber:
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => EnterAccountNumberScreen(selectedBank: args),
          );
        }
        return _errorRoute();
      case enterAccountDetails:
        if (args is Map<String, String>) {
          return MaterialPageRoute(
            builder: (context) => EnterAccountDetailsScreen(selectedBank: args),
          );
        }
        return _errorRoute();
      case enterTransferAmount:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => EnterTransferAmountScreen(
              selectedBank: (args['selectedBank'] as Map<String, dynamic>).cast<String, String>(),
              accountNumber: args['accountNumber'] as String,
              recipientName: args['recipientName'] as String,
            ),
          );
        }
        return _errorRoute();
      case confirmDetails:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => ConfirmDetailsScreen(
              selectedBank: args['selectedBank'] as Map<String, String>,
              accountNumber: args['accountNumber'] as String,
              recipientName: args['recipientName'] as String,
              amount: args['amount'] as double,
              remark: args['remark'] as String,
            ),
          );
        }
        return _errorRoute();
      case pin:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => EnterPinScreen(
              transactionDetails: args,
            ),
          );
        }
        return _errorRoute();
      case transferSuccess:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => TransactionSuccessfulScreen(
              amount: args['amount'] as double,
            ),
          );
        }
        return _errorRoute();
      case accountNumber:
        return MaterialPageRoute(builder: (context) => const AccountEntryScreen());

      case airtimePurchase:
        return MaterialPageRoute(builder: (context) => const AirtimePurchaseScreen());
      case airtimeProvider:
        return MaterialPageRoute(builder: (context) => const AirtimeProviderScreen());
      case airtimePhone:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => AirtimePhoneScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
            ),
          );
        }
        return _errorRoute();
      case airtimeAmount:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => AirtimeAmountScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              phoneNumber: args['phoneNumber'] as String,
            ),
          );
        }
        return _errorRoute();
      case airtimeConfirm:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => AirtimeConfirmScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              phoneNumber: args['phoneNumber'] as String,
              amount: args['amount'] as double,
            ),
          );
        }
        return _errorRoute();
      case airtimeSuccess:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => AirtimeSuccessScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              phoneNumber: args['phoneNumber'] as String,
              amount: args['amount'] as double,
              currency: args['currency'] as String,
            ),
          );
        }
        return _errorRoute();
      case dataPage:
        return MaterialPageRoute(builder: (context) => const DataPage());
      case dataProvider:
        return MaterialPageRoute(builder: (context) => const DataProviderScreen());
      case dataPackage:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => DataPackageScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
            ),
          );
        }
        return _errorRoute();
      case dataPhone:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => DataPhoneScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
            ),
          );
        }
        return _errorRoute();
      case dataConfirm:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => DataConfirmScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
              phoneNumber: args['phoneNumber'] as String,
            ),
          );
        }
        return _errorRoute();
      case dataSuccess:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => DataSuccessScreen(
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
              phoneNumber: args['phoneNumber'] as String,
              currency: args['currency'] as String,
            ),
          );
        }
        return _errorRoute();
      case billsCategory:
        return MaterialPageRoute(builder: (context) => const BillsCategoryScreen());
      case billsProvider:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => BillsProviderScreen(
              selectedCategory: args['selectedCategory'] as Map<String, dynamic>,
            ),
          );
        }
        return _errorRoute();
      case billsPackage:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => BillsPackageScreen(
              selectedCategory: args['selectedCategory'] as Map<String, dynamic>,
              selectedProvider: args['selectedProvider'] as Map<String, String>,
            ),
          );
        }
        return _errorRoute();
      case billsSmartcard:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => BillsSmartcardScreen(
              selectedCategory: args['selectedCategory'] as Map<String, dynamic>,
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
            ),
          );
        }
        return _errorRoute();
      case billsConfirm:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => BillsConfirmScreen(
              selectedCategory: args['selectedCategory'] as Map<String, dynamic>,
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
              smartcardNumber: args['smartcardNumber'] as String,
              amount: args['amount'] as double,
            ),
          );
        }
        return _errorRoute();
      case billsSuccess:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => BillsSuccessScreen(
              selectedCategory: args['selectedCategory'] as Map<String, dynamic>,
              selectedProvider: args['selectedProvider'] as Map<String, String>,
              selectedPackage: args['selectedPackage'] as Map<String, dynamic>,
              smartcardNumber: args['smartcardNumber'] as String,
              amount: args['amount'] as double,
              currency: args['currency'] as String,
            ),
          );
        }
        return _errorRoute();
      case notifications:
        return MaterialPageRoute(builder: (context) => const NotificationsScreen());
      case moreServices:
        return MaterialPageRoute(builder: (context) => const MoreServicesScreen());
      case transactionHistory:
        return MaterialPageRoute(builder: (context) => const TransactionHistoryScreen());
      case profileDetails:
        return MaterialPageRoute(builder: (context) => const ProfileDetailsScreen());
      case payBills:
        return MaterialPageRoute(builder: (context) => const PayBillsScreen());
      case selectNetwork:
        return MaterialPageRoute(builder: (context) => const SelectNetworkPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Error: Unknown route')),
      );
    });
  }
}
