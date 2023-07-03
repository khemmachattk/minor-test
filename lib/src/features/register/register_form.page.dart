import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minor_register/src/common/utils/snack_helper.dart';
import 'package:minor_register/src/common/utils/validate_utils.dart';
import 'package:minor_register/src/common/widgets/app_button.dart';
import 'package:minor_register/src/common/widgets/app_input.dart';
import 'package:minor_register/src/features/register/register.cubit.dart';
import 'package:minor_register/src/features/register/register_otp.page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _firstNameFocus.requestFocus();
  }

  Future<void> onSubmitted() async {
    if (!_formKey.currentState!.validate()) {
      showSnackBar(
        context,
        text: 'Please fill the form',
        type: SnackBarType.error,
      );
      return;
    }
    _formKey.currentState!.save();
    try {
      await context.read<RegisterCubit>().otpRequest();
    } catch (e) {
      showSnackBar(
        context,
        text: e.toString(),
        type: SnackBarType.error,
      );
    }
    if (context.mounted) {
      final bool? completed = await Navigator.of(context).push<bool>(
        RegisterOtpPage.route(),
      );
      if (completed == true) {
        _firstNameFocus.requestFocus();
        _formKey.currentState!.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppInput(
                name: 'First name',
                focusNode: _firstNameFocus,
                onSave: (value) {
                  context.read<RegisterCubit>().updateData(firstName: value);
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter first name';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInput(
                name: 'Last name',
                onSave: (value) {
                  context.read<RegisterCubit>().updateData(lastName: value);
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter last name';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInput(
                name: 'Mobile tel',
                onSave: (value) {
                  context.read<RegisterCubit>().updateData(mobileTel: value);
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter first name';
                  if (!isMobile(value)) return 'Mobile tel incorrect';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                return AppButton(
                  title: 'REGISTER',
                  isLoading: state.isLoading,
                  onPress: onSubmitted,
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameFocus.dispose();
    super.dispose();
  }
}
