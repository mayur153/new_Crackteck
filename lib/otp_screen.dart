import 'dart:async';
import 'package:flutter/material.dart';
import 'package:final_crackteck/constants/app_colors.dart';
import 'package:final_crackteck/constants/app_spacing.dart';
import 'package:final_crackteck/routes/app_routes.dart';
import 'package:final_crackteck/services/api_service.dart';
import 'package:final_crackteck/widgets/custom_button.dart';

class OtpArguments {
  final int roleId;
  final String roleName;
  final String phoneNumber;

  OtpArguments({
    required this.roleId,
    required this.roleName,
    required this.phoneNumber,
  });
}

class OtpVerificationScreen extends StatefulWidget {
  final OtpArguments args;

  const OtpVerificationScreen({super.key, required this.args});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final ApiService _apiService = ApiService.instance;
  final TextEditingController _otpController = TextEditingController();

  bool _isVerifying = false;
  bool _canResend = false;

  int _secondsLeft = 80;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void startTimer() {
    _secondsLeft = 80;
    _canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.length != 4) {
      _showSnack("Please enter a valid 4-digit OTP");
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final res = await _apiService.verifyOtp(
        phoneNumber: widget.args.phoneNumber,
        otp: otp,
        roleId: widget.args.roleId,
      );

      if (!mounted) return;

      if (res.success) {
        _navigateByRole(widget.args.roleId);
      } else {
        _showSnack(res.message ?? "Invalid OTP");
      }
    } catch (e) {
      _showSnack("Network error while verifying OTP");
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  void _navigateByRole(int roleId) {
    switch (roleId) {
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.adminDashboard,
              (route) => false,
        );
        break;

      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.residentDashboard,
              (route) => false,
        );
        break;

      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.securityDashboard,
              (route) => false,
        );
        break;

      default:
        _showSnack("Unknown role");
    }
  }

  Future<void> resendOtp() async {
    if (!_canResend) return;

    final response = await _apiService.login(
      roleId: widget.args.roleId,
      phoneNumber: widget.args.phoneNumber,
    );

    if (response.success) {
      _showSnack("OTP resent successfully");
      startTimer();
    } else {
      _showSnack("Failed to resend OTP");
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _otpBox(int index) {
    return Container(
      height: 55,
      width: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        index < _otpController.text.length
            ? _otpController.text[index]
            : "",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: BackButton(color: AppColors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Verifying\nyour number",
              style: TextStyle(
                fontSize: 30,
                height: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "We've sent your verification code to",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              args.phoneNumber,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            // OTP Boxes
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _openOtpKeyboard();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, _otpBox),
              ),
            ),

            Opacity(
              opacity: 0,
              child: TextField(
                controller: _otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
            ),

            const SizedBox(height: 25),

            CustomButton(
              text: "Verify",
              onPressed: verifyOtp,
              isLoading: _isVerifying,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: resendOtp,
                  child: Text(
                    "Resend code",
                    style: TextStyle(
                      color: _canResend ? Colors.black : Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _canResend
                      ? "Expired"
                      : "${_secondsLeft ~/ 60}:${(_secondsLeft % 60).toString().padLeft(2, '0')} left",
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openOtpKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
