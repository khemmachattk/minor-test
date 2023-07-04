import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minor_register/src/common/utils/snack_helper.dart';
import 'package:minor_register/src/common/widgets/app_button.dart';
import 'package:minor_register/src/features/register/register.cubit.dart';

class RegisterOtpPage extends StatefulWidget {
  const RegisterOtpPage({
    super.key,
  });

  static Route<bool> route() {
    return MaterialPageRoute<bool>(builder: (_) {
      return const RegisterOtpPage();
    });
  }

  @override
  State<StatefulWidget> createState() {
    return _RegisterOtpState();
  }
}

class _RegisterOtpState extends State<RegisterOtpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _inputFocus = FocusNode();
  Timer? _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _inputFocus.requestFocus();

    countTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countTime();
    });
  }

  void countTime() {
    final otpExpireAt = context.read<RegisterCubit>().state.otpExpireAt!;
    setState(() {
      _counter = otpExpireAt.difference(DateTime.now()).inSeconds;
      if (_counter <= 0) _counter = 0;
    });
  }

  Future<void> onSubmitted() async {
    bool completed = false;
    try {
      completed = await context.read<RegisterCubit>().register();
    } catch (e) {
      showSnackBar(context, text: e.toString(), type: SnackBarType.error);
      return;
    }

    if (completed && context.mounted) {
      showSnackBar(
        context,
        text: 'Register successfully',
      );
      Navigator.pop(context, true);
    } else {
      showSnackBar(context, text: 'Register fail', type: SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
      ),
      body: SafeArea(
        child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Visibility(
                  visible: false,
                  maintainState: true,
                  child: TextFormField(
                    initialValue: state.otp,
                    focusNode: _inputFocus,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (value) {
                      context.read<RegisterCubit>().updateData(otp: value);
                    },
                    onTapOutside: (_) {
                      _inputFocus.unfocus();
                    },
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      const TextSpan(text: 'Enter OTP send to '),
                      TextSpan(
                        text: state.mobileTel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' (ref: ${state.refCode})'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire in $_counter seconds',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TapRegion(
                  onTapInside: (_) {
                    _inputFocus.requestFocus();
                  },
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _generateOtpInput(state.otp),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onPress: onSubmitted,
                  isLoading: state.isLoading,
                  title: 'CONFIRM',
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    context.read<RegisterCubit>().otpRequest();
                  },
                  child: const Text('Resend OTP?'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _generateOtpInput(String otp) {
    return List.generate(
      6,
      (index) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: Colors.deepPurple,
                ),
              ),
              child: Center(
                child: Text(
                  otp.length <= index ? '' : otp.characters.elementAt(index),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputFocus.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
