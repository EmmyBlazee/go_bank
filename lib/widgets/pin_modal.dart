import 'package:flutter/material.dart';
import '../colors.dart';

class PinModal extends StatefulWidget {
  final String amount;
  final VoidCallback onSuccess;
  final VoidCallback? onCancel;

  const PinModal({
    super.key,
    required this.amount,
    required this.onSuccess,
    this.onCancel,
  });

  @override
  State<PinModal> createState() => _PinModalState();
}

class _PinModalState extends State<PinModal> with SingleTickerProviderStateMixin {
  String _pin = '';
  final int _pinLength = 4;
  int _wrongAttempts = 0;
  final int _maxAttempts = 3;
  bool _isError = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

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
      _verifyPin();
    }
  }

  void _verifyPin() {
    const correctPin = '1234';

    if (_pin == correctPin) {
      // Correct PIN
      Navigator.of(context).pop(); // Close modal first
      widget.onSuccess(); // Then navigate
    } else {
      // Wrong PIN
      _wrongAttempts++;
      setState(() {
        _pin = '';
        _isError = true;
      });

      _shakeController.forward(from: 0);

      // Reset error state after animation
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isError = false;
          });
        }
      });

      if (_wrongAttempts >= _maxAttempts) {
        // Too many attempts
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Too many attempts. Try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect PIN. Try again. (${_maxAttempts - _wrongAttempts} attempts left)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          
          children: [
            // Header
             const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter PIN to complete transaction',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onCancel?.call();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Amount display
            Text(
              'Amount: ${widget.amount}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // PIN dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isError ? Colors.red : (index < _pin.length ? AppColors.primary : Colors.grey[300]!),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
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
            const SizedBox(height: 32),
            // Numpad
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: [
                for (int i = 1; i <= 9; i++)
                  _buildKeypadButton(i.toString()),
                const SizedBox.shrink(),
                _buildKeypadButton('0'),
                _buildBackspaceButton(),
              ],
            ),
            const SizedBox(height: 16),
            // Fingerprint option
            TextButton.icon(
              onPressed: () {
                // TODO: Implement fingerprint authentication
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fingerprint authentication coming soon')),
                );
              },
              icon: const Icon(Icons.fingerprint, color: AppColors.primary),
              label: const Text(
                'Use Fingerprint',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
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

void showPinModal({
  required BuildContext context,
  required String amount,
  required VoidCallback onSuccess,
  VoidCallback? onCancel,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints.expand(),
    builder: (context) => PinModal(
      amount: amount,
      onSuccess: onSuccess,
      onCancel: onCancel,
    ),
  );
}
