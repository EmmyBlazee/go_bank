import 'package:flutter/material.dart';
import '../colors.dart';
import '../app_routes.dart';

class PinScreen extends StatefulWidget {
  final Map<String, dynamic> transactionDetails;
  const PinScreen({super.key, required this.transactionDetails});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _pin = '';
  final int _pinLength = 4;

  void _onKeyPressed(String value) {
    if (value == 'backspace') {
      if (_pin.isNotEmpty) {
        setState(() {
          _pin = _pin.substring(0, _pin.length - 1);
        });
      }
    } else if (_pin.length < _pinLength) {
      setState(() {
        _pin += value;
      });
    }

    if (_pin.length == _pinLength) {
      // Simulate PIN verification delay
      Future.delayed(const Duration(milliseconds: 500), () {
        final type = widget.transactionDetails['type'] as String?;

        if (type == 'transfer') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.transferSuccess,
            (route) => false,
            arguments: widget.transactionDetails,
          );
        } else if (type == 'airtime') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.airtimeSuccess,
            (route) => false,
            arguments: widget.transactionDetails,
          );
        } else if (type == 'data') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dataSuccess,
            (route) => false,
            arguments: widget.transactionDetails,
          );
        } else if (type == 'bills') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.billsSuccess,
            (route) => false,
            arguments: widget.transactionDetails,
          );
        } else {
          // Fallback or error case
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.home, (route) => false);
        }
      });
    }
  }

  Future<void> _showCancelDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Transaction?'),
        content: const Text('Are you sure you want to cancel this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (result == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope( // Updated to use PopScope for consistent back navigation handling
      canPop: false, // Block system back button
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showCancelDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _showCancelDialog,
          ),
          title: const Text('Enter PIN'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 120.0, left: 24.0, right: 24.0),
          child: Column(
            
            children: [
 const SizedBox(height: 120),
              const Text(
                'Enter your 4-digit PIN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your transaction PIN to complete the transfer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pinLength, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: index < _pin.length ? AppColors.primary : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 48),
              GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 1; i <= 9; i++)
                    _buildKeypadButton(i.toString()),
                  const SizedBox.shrink(),
                  _buildKeypadButton('0'),
                  _buildBackspaceButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String value) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => _onKeyPressed(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => _onKeyPressed('backspace'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Icon(
          Icons.backspace,
          size: 24,
        ),
      ),
    );
  }
}
