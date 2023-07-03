import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minor_register/src/network/minor_api/data/otp_data.dart';
import 'package:minor_register/src/network/minor_api/minor_api.dart';

class RegisterState {
  final bool isLoading;
  final String firstName;
  final String lastName;
  final String mobileTel;
  final String refCode;
  final String otp;
  final DateTime? otpExpireAt;

  RegisterState({
    this.isLoading = false,
    this.firstName = '',
    this.lastName = '',
    this.mobileTel = '',
    this.refCode = '',
    this.otp = '',
    this.otpExpireAt,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? firstName,
    String? lastName,
    String? mobileTel,
    String? refCode,
    String? otp,
    DateTime? otpExpireAt,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileTel: mobileTel ?? this.mobileTel,
      refCode: refCode ?? this.refCode,
      otp: otp ?? this.otp,
      otpExpireAt: otpExpireAt ?? this.otpExpireAt,
    );
  }
}

class RegisterCubit extends Cubit<RegisterState> {
  MinorApi minorApi;

  RegisterCubit({
    required this.minorApi,
  }) : super(RegisterState());

  void updateData({
    String? firstName,
    String? lastName,
    String? mobileTel,
    String? otp,
  }) {
    emit(state.copyWith(
      firstName: firstName,
      lastName: lastName,
      mobileTel: mobileTel,
      otp: otp,
    ));
  }

  Future<OtpData> otpRequest() async {
    emit(state.copyWith(isLoading: true));
    try {
      final otpData = await minorApi.otpRequest(
        firstName: state.firstName,
        lastName: state.lastName,
        mobileTel: state.mobileTel,
      );
      emit(state.copyWith(
        refCode: otpData.refCode,
        otp: otpData.otp,
        otpExpireAt: DateTime.now().add(const Duration(minutes: 5))
      ));
      return otpData;
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<bool> register() async {
    emit(state.copyWith(isLoading: true));
    try {
      final completed = await minorApi.customerRegister(
        firstName: state.firstName,
        lastName: state.lastName,
        mobileTel: state.mobileTel,
        refCode: state.refCode,
        otp: state.otp,
      );
      emit(state.copyWith(
        firstName: '',
        lastName: '',
        mobileTel: '',
        refCode: '',
        otp: '',
      ));
      return completed;
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
