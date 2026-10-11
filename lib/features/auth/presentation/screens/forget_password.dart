import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import 'package:greengrocer/core/resources/widget/custom_form_field.dart';
import 'package:greengrocer/features/auth/domain/usecases/auth_usecases.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final forgetPasswordUseCase = sl<ForgetPasswordUseCase>();

    final result = await forgetPasswordUseCase(
      _emailController.text.trim(),
    );

    setState(() => _isLoading = false);

    result.fold(
          (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Colors.red,
          ),
        );
      },
          (newPassword) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('New Password'),
            content: Text(
              'Your new password is: $newPassword',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/signIn");
                },
                child: const Text('Login Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: isLandscape ? 10 : 50,
              left: isLandscape ? 15 : 36,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: responsive.scaleWidth(isLandscape ? 18 : 28),
                  color: AppColors.black,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(30),
                  vertical: 20,
                ),
                child: isLandscape
                    ? _buildLandscapeLayout(context, responsive)
                    : _buildPortraitLayout(context, responsive),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, Responsive responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildHeader(responsive, false),
          SizedBox(height: responsive.scaleHeight(40)),
          _buildEmailField(responsive, false),
          SizedBox(height: responsive.scaleHeight(48)),
          _buildSubmitButton(),
          SizedBox(height: responsive.scaleHeight(20)),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Responsive responsive) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _buildHeader(responsive, true),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEmailField(responsive, true),
                SizedBox(height: responsive.scaleHeight(20)),
                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Text(
          "Fruit Market",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 18 : 42),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        Text(
          "Enter your Email",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 28),
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(Responsive responsive, bool isLandscape) {
    return CustomFormField(
      hintText: "Enter your email",
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : CustomButton(
      text: "Submit",
      onTap: _onSubmit,
      color: AppColors.green,
      textColor: AppColors.white,
    );
  }
}