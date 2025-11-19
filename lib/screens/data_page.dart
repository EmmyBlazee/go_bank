import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:go_bank/colors.dart';
import 'package:go_bank/app_routes.dart';

// The new "Data Home Page"
class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool _isBalanceHidden = true; // State for balance visibility
  Map<String, dynamic>? _selectedPlan;
  String _selectedTab = "Hot";
  bool _isFormValid = false;
  String? _selectedNetwork;
  final TextEditingController _phoneController = TextEditingController();

  final List<String> _networks = ['MTN', 'Airtel', 'Glo', '9mobile'];
  final List<Map<String, dynamic>> _dataPlans = [
    {'name': '100MB', 'price': 100.00, 'validity': '1 day', 'type': 'Daily'},
    {'name': '200MB', 'price': 200.00, 'validity': '1 day', 'type': 'Daily'},
    {'name': '500MB', 'price': 500.00, 'validity': '1 day', 'type': 'Daily'},
    {'name': '1GB', 'price': 1000.00, 'validity': '7 days', 'type': 'Weekly'},
    {'name': '2GB', 'price': 2000.00, 'validity': '7 days', 'type': 'Weekly'},
    {'name': '5GB', 'price': 5000.00, 'validity': '30 days', 'type': 'Monthly'},
    {'name': '10GB', 'price': 10000.00, 'validity': '30 days', 'type': 'Monthly'},
    {'name': '20GB', 'price': 20000.00, 'validity': '60 days', 'type': '2-Months'},
    {'name': '50GB', 'price': 50000.00, 'validity': '60 days', 'type': '2-Months'},
    {'name': ' 1GB', 'price': 750.00, 'validity': '3 days', 'type': 'Hot'},
    {'name': '2GB', 'price': 1500.00, 'validity': '7 days', 'type': 'Hot'},
  ];

  List<Map<String, dynamic>> get _filteredDataPlans {
    return _dataPlans.where((plan) => _selectedTab == "Hot" || plan['type'] == _selectedTab).toList();
  }
  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceHidden = !_isBalanceHidden;
    });
  }

  void _validateForm() {
    final isFormValid = _selectedNetwork != null &&
        _phoneController.text.length == 11 &&
        _selectedPlan != null;
    if (_isFormValid != isFormValid) {
      setState(() => _isFormValid = isFormValid);
    }
  }

  void _onProceed() {
    if (!_isFormValid) return;

    final selectedProvider = {'name': _selectedNetwork!, 'logo': _selectedNetwork!};

    Navigator.pushNamed(
      context,

      AppRoutes.dataConfirm,
      arguments: {
        'selectedProvider': selectedProvider,
        'selectedPackage': _selectedPlan,
        'phoneNumber': _phoneController.text,
        'type': 'data', // Add transaction type
      },
    );

  }

  @override
  void initState() {
    super.initState();
    _phoneController.text = "09033564931"; // Pre-fill phone number
    _selectedNetwork = _networks.first; // Set default network
    _phoneController.addListener(_validateForm);
    _validateForm();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF), // Light background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - Balance Card
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Back button and title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 60),
                      Text(
                        'Data',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Nigerian flag and balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          children: [
                            Container(width: 6.67, color: Colors.green),
                            Container(width: 6.66, color: Colors.white),
                            Container(width: 6.67, color: Colors.green),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Current Balance',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Balance amount with eye icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isBalanceHidden ? '********' : '₦155,600.24',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          _isBalanceHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white70,
                          size: 20,
                        ),
                        onPressed: _toggleBalanceVisibility,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Account Number
                  Text(
                    'Account Number: 1234567890', // Static for now, as per request
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButton<String>(
                          value: _selectedNetwork,
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedNetwork = newValue;
                              _validateForm();
                            });
                          },
                          items: _networks.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Center(child: Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600))));
                          }).toList(),
                        ),
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(Icons.person, color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Space between textfield and tab bar
            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  _buildTab("Hot"),
                  _buildTab("Daily"),
                  _buildTab("Weekly"),
                  _buildTab("Monthly"),
                  _buildTab("2-Months"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Data Plan Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 8,
                ),
                itemCount: _filteredDataPlans.length,
                itemBuilder: (context, index) {
                  final plan = _filteredDataPlans[index];
                  return _buildDataCard(plan);
                },
              ),
            ),
            const SizedBox(height: 40),
            // Continue Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _onProceed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? AppColors.primary : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    final isSelected = _selectedTab == text;
    return InkWell(
      onTap: () => setState(() {
        _selectedTab = text;
      }),
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? const Color(0xFF0057FF) : Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          if (isSelected)
            Container(
              height: 2,
              width: 20,
              color: const Color(0xFF0057FF), // Blue underline
            ),
        ],
      ),
    );
  }
  
  Widget _buildDataCard(Map<String, dynamic> plan) {
    final bool isSelected = _selectedPlan == plan;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPlan = plan;
          _validateForm();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0057FF) : AppColors.primary.withAlpha(26),
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? Border.all(color: const Color(0xFF0057FF), width: 1.5) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  plan['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  "₦${plan['price']}",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              plan['validity'],
              style: GoogleFonts.inter(fontSize: 11, color: isSelected ? Colors.white70 : Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
