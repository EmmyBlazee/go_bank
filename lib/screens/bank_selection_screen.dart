import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

class BankSelectionScreen extends StatefulWidget {
  const BankSelectionScreen({super.key});

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class Bank {
  final String name;
  final String code;
  final Color color;

  Bank({
    required this.name,
    required this.code,
    required this.color,
  });
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Bank> _allBanks = [
    Bank(name: 'Palmpay', code: '001', color: const Color(0xFF9C27B0)),
    Bank(name: 'Opay', code: '002', color: const Color(0xFF2196F3)),
    Bank(name: 'United Bank For Africa', code: '033', color: const Color(0xFFFF9800)),
    Bank(name: 'Access Bank', code: '044', color: const Color(0xFF00BCD4)),
    Bank(name: 'Ecobank', code: '050', color: const Color(0xFFE91E63)),
    Bank(name: 'Guaranty Trust Bank', code: '058', color: const Color(0xFFFF5722)),
    Bank(name: 'First Bank', code: '011', color: const Color(0xFF673AB7)),
    Bank(name: 'FCMB', code: '214', color: const Color(0xFF009688)),
    Bank(name: 'Zenith Bank', code: '057', color: const Color(0xFF3F51B5)),
    Bank(name: 'Kuda Bank', code: '003', color: const Color(0xFF4CAF50)),
    Bank(name: 'Moniepoint', code: '004', color: const Color(0xFF2196F3)),
  ];

  List<Bank> get _frequentlyUsedBanks => _allBanks.take(4).toList();

  List<Bank> get _filteredBanks {
    if (_searchQuery.isEmpty) {
      return _allBanks;
    }
    return _allBanks
        .where((bank) =>
            bank.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            bank.code.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Widget _buildBankIcon(Bank bank) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: bank.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          bank.name.substring(0, 1),
          style: GoogleFonts.sora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: bank.color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Bank',
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for bank',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          // Frequently Used Section
          if (_searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Used',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _frequentlyUsedBanks.length,
                      itemBuilder: (context, index) {
                        final bank = _frequentlyUsedBanks[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context, bank.name),
                            child: Column(
                              children: [
                                _buildBankIcon(bank),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    bank.name,
                                    style: GoogleFonts.sora(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'All Banks',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          // All Banks List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBanks.length,
              itemBuilder: (context, index) {
                final bank = _filteredBanks[index];
                return GestureDetector(
                  onTap: () => Navigator.pop(context, bank.name),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6.0,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        _buildBankIcon(bank),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bank.name,
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Code: ${bank.code}',
                                style: GoogleFonts.sora(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
