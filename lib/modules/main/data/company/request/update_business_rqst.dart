import 'dart:io';

import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class UpgradeBusinessRequest {
  final String email;
  final String phone;
  final String name;
  final String address;
  final int logo;
  final String overview;
  final double longitude;
  final double latitude;

  UpgradeBusinessRequest({
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
    required this.logo,
    required this.overview,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'address': address,
      'logo': logo,
      'overview': overview,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}

class RequestUpdateBusiness {
  final File? logo;
  final File? background;
  final CompanyEntity companyEntity;

  RequestUpdateBusiness(
      {required this.logo,
      required this.background,
      required this.companyEntity
      });
}

