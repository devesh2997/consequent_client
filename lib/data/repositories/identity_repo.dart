import 'dart:convert';
import 'dart:developer';

import 'package:consequent_client/data/dtos/api_response.dart';
import 'package:consequent_client/data/dtos/token.dart';
import 'package:consequent_client/data/dtos/verification_id.dart';
import 'package:consequent_client/data/mappers/token.dart';
import 'package:consequent_client/domain/entities/token.dart';
import 'package:consequent_client/domain/repositories/identity_repo.dart';
import 'package:consequent_client/domain/services/exceptions.dart';
import 'package:http/http.dart' as http;

class IdentityAPIConstants {
  static String baseURL = "some-parks-share-122-161-84-118.loca.lt";

  static String sendOTPEndpoint = "identity/v1/send-otp";
  static String verifyOTPEndpoint = "identity/v1/verify-otp";
}

class IdentityRepoImpl implements IdentityRepo {
  @override
  Future<String> sendOTP(int mobileNumber) async {
    try {
      var url = Uri.https(
          IdentityAPIConstants.baseURL,
          IdentityAPIConstants.sendOTPEndpoint,
          {"mobile_number": mobileNumber.toString()});
      var response = await http.post(url, body: {});

      APIResponse<VerificationID> res = APIResponse.fromJson(
          jsonDecode(response.body), VerificationID.fromJson);

      return res.data?.verificationID ?? "";
    } catch (e) {
      log(e.toString()); // TODO (devesh2997) | handle exception
      rethrow;
    }
  }

  @override
  Future<Token> signInWithEmail(String email, String password) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Token> verifyOTP(
      String verificationID, int mobileNumber, int otp) async {
    try {
      var url = Uri.https(
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
