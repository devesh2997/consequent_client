import 'dart:convert';
import 'dart:developer';

import 'package:consequent_client/data/dtos/api_response.dart';
import 'package:consequent_client/data/dtos/is_email_registered.dart';
import 'package:consequent_client/data/dtos/token.dart';
import 'package:consequent_client/data/dtos/verification_id.dart';
import 'package:consequent_client/data/mappers/token.dart';
import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:http/http.dart' as http;

class IdentityAPIConstants {
  static String baseURL = "198.211.115.203:5035";

  static String sendOTPEndpoint = "identity/v1/send-otp";
  static String verifyOTPEndpoint = "identity/v1/verify-otp";
  static String signInWithEmailEndpoint = "identity/v1/sign-in-with-email";
  static String signUpWithEmailEndpoint = "identity/v1/sign-up-with-email";
  static String isEmailRegisteredEndpoint = "identity/v1/is-email-registered";
}

class IdentityRepoImpl implements IdentityRepo {
  @override
  Future<String> sendOTP(int mobileNumber) async {
    try {
      var url = Uri.http(
          IdentityAPIConstants.baseURL,
          IdentityAPIConstants.sendOTPEndpoint,
          {"mobile_number": mobileNumber.toString()});
      var response = await http.post(url, body: {});

      if (response.statusCode != 200) {
        throw APIException(response.reasonPhrase);
      }

      APIResponse<VerificationID> res = APIResponse.fromJson(
          jsonDecode(response.body), VerificationID.fromJson);

      if (res.isSuccess()) {
        return res.data?.verificationID ?? "";
      }

      throw APIException(res.error());
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }

  @override
  Future<Token> signInWithEmail(String email, String password) async {
    try {
      var url = Uri.http(
        IdentityAPIConstants.baseURL,
        IdentityAPIConstants.signInWithEmailEndpoint,
      );
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      if (response.statusCode != 200) {
        throw APIException(response.reasonPhrase);
      }

      APIResponse<TokenDTO> res =
          APIResponse.fromJson(jsonDecode(response.body), TokenDTO.fromJson);

      if (res.isFailed()) {
        throw APIException(res.error());
      }

      var tokenDTO = res.data;
      var token = TokenMapper()
          .toEntity(tokenDTO ?? TokenDTO(JWTTokenDTO(""), RefreshTokenDTO("")));

      return token;
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }

  @override
  Future<bool> isEmailRegistered(String email) async {
    try {
      var url = Uri.http(
        IdentityAPIConstants.baseURL,
        IdentityAPIConstants.isEmailRegisteredEndpoint,
        {
          "email": email,
        },
      );
      var response = await http.get(url);

      if (response.statusCode != 200) {
        throw APIException(response.reasonPhrase);
      }

      APIResponse<IsEmailRegistered> res = APIResponse.fromJson(
          jsonDecode(response.body), IsEmailRegistered.fromJson);

      if (res.isFailed()) {
        throw APIException(res.error());
      }

      return res.data?.registered ?? false;
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }

  @override
  Future<Token> signUpWithEmail(String email, String password) async {
    try {
      var url = Uri.http(
        IdentityAPIConstants.baseURL,
        IdentityAPIConstants.signUpWithEmailEndpoint,
      );
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      if (response.statusCode != 200) {
        throw APIException(response.reasonPhrase);
      }

      APIResponse<TokenDTO> res =
          APIResponse.fromJson(jsonDecode(response.body), TokenDTO.fromJson);

      if (res.isFailed()) {
        throw APIException(res.error());
      }

      var tokenDTO = res.data;
      var token = TokenMapper()
          .toEntity(tokenDTO ?? TokenDTO(JWTTokenDTO(""), RefreshTokenDTO("")));

      return token;
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }

  @override
  Future<Token> verifyOTP(
      String verificationID, int mobileNumber, int otp) async {
    try {
      var url = Uri.http(
        IdentityAPIConstants.baseURL,
        IdentityAPIConstants.verifyOTPEndpoint,
      );
      var response = await http.post(url, body: {
        "mobile_number": mobileNumber.toString(),
        "verification_id": verificationID,
        "otp": otp.toString()
      });

      if (response.statusCode != 200) {
        throw APIException(response.reasonPhrase);
      }

      APIResponse<TokenDTO> res =
          APIResponse.fromJson(jsonDecode(response.body), TokenDTO.fromJson);

      if (res.isFailed()) {
        throw APIException(res.error());
      }

      var tokenDTO = res.data;
      var token = TokenMapper()
          .toEntity(tokenDTO ?? TokenDTO(JWTTokenDTO(""), RefreshTokenDTO("")));

      return token;
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }
}
