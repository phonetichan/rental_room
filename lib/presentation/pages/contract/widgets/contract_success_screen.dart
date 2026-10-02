import 'package:flutter/material.dart';
import 'package:rental_room/domain/entity/contract_entity.dart';

class ContractSuccessScreen extends StatelessWidget {
  const ContractSuccessScreen({super.key, required ContractEntity contract});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF7C53E4);
    const softAccentRing = Color(0xFFF3EDFF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Contract Success Badge Container
              Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  color: softAccentRing,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Title
              const Text(
                'Contract Saved!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1B2E),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle / Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your rental agreement voucher has been successfully created and saved. You can review the details anytime in your contract list.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF9E9DB0),
                  ),
                ),
              ),

      const Spacer(),

              // Done Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Pop back twice (success screen and contract detail page) or pop until previous route
                    Navigator.of(context).popUntil((route) => route.isFirst || route.settings.name == '/' || !Navigator.of(context).canPop());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
