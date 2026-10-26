
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/views/widgets/custom_contact_info_card.dart';
import 'package:provider/provider.dart';

class ProfileContactSection extends StatefulWidget {
  final String email;
  final String? phone;

  const ProfileContactSection({
    super.key,
    required this.email,
    required this.phone,
  });

  @override
  State<ProfileContactSection> createState() =>
      _ProfileContactSectionState();
}

class _ProfileContactSectionState
    extends State<ProfileContactSection> {
  late String? _phone;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _phone = widget.phone?.trim();

    if (_phone != null && _phone!.isEmpty) {
      _phone = null;
    }
  }

  @override
  void didUpdateWidget(covariant ProfileContactSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.phone != widget.phone) {
      _phone = widget.phone?.trim();

      if (_phone != null && _phone!.isEmpty) {
        _phone = null;
      }
    }
  }

  Future<void> _showAddPhoneDialog() async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool saving = false;

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setDialogState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Add Phone Number'),
                content: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Mobile number',
                      hintText: 'Enter 10-digit number',
                      prefixIcon: Icon(Icons.phone_android),
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final mobile = value?.trim() ?? '';

                      if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
                        return 'Enter a valid 10-digit number';
                      }

                      return null;
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: saving
                        ? null
                        : () => Navigator.pop(dialogContext),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF33A444),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: saving
                        ? null
                        : () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            setDialogState(() => saving = true);

                            if (mounted) {
                              setState(() => _isSaving = true);
                            }

                            try {
                              final result =
                                  await AuthService().updateMobile(
                                mobile: controller.text.trim(),
                              );

                              if (!mounted) return;

                              if (result['success'] == true) {
                                final savedMobile =
                                    result['mobile']?.toString() ??
                                    controller.text.trim();

                                setState(() {
                                  _phone = savedMobile;
                                  _isSaving = false;
                                });

                                Navigator.pop(dialogContext);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result['message']?.toString() ??
                                          'Phone number saved successfully.',
                                    ),
                                    backgroundColor:
                                        const Color(0xFF33A444),
                                  ),
                                );

                                context
                                    .read<HomeProvider>()
                                    .getHomeDatas();
                              } else {
                                setDialogState(() => saving = false);
                                setState(() => _isSaving = false);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result['message']?.toString() ??
                                          'Unable to save phone number.',
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (!mounted) return;

                              setDialogState(() => saving = false);
                              setState(() => _isSaving = false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Something went wrong. Please try again.',
                                  ),
                                ),
                              );
                            }
                          },
                    child: saving
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      controller.dispose();

      if (mounted && _isSaving) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPhone = _phone != null && _phone!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomContactInfoCard(
          email: widget.email,
          phone: hasPhone ? _phone! : 'Not added',
        ),
        if (!hasPhone)
          Padding(
            padding: EdgeInsets.only(
              top: context.height * 0.002,
              bottom: context.height * 0.015,
            ),
            child: OutlinedButton.icon(
              onPressed: _isSaving ? null : _showAddPhoneDialog,
              icon: const Icon(Icons.add_call, size: 20),
              label: const Text('Add Phone Number'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF33A444),
                side: const BorderSide(
                  color: Color(0xFF33A444),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
