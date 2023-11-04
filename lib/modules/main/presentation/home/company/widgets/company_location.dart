import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyLocationWidget extends StatefulWidget {
  const CompanyLocationWidget({super.key});

  @override
  State<CompanyLocationWidget> createState() => _CompanyLocationWidgetState();
}

class _CompanyLocationWidgetState extends State<CompanyLocationWidget> {
  final LocationLib locationLib = LocationLib();
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Scaffold(
          body: FutureBuilder(
            future: locationLib.getCurrentLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Feature not available on your device'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final Position myLocation = snapshot.data as Position;
                return GoogleMap(
                  onMapCreated: (controller) => _controller.complete(controller),
                  initialCameraPosition:
                      CameraPosition(target: LatLng(companyEntity.latitude, companyEntity.longitude), zoom: 20),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  trafficEnabled: true,
                  mapType: MapType.normal,
                  markers: {
                    Marker(
                      markerId: MarkerId(companyEntity.id.toString()),
                      position: LatLng(companyEntity.latitude, companyEntity.longitude),
                      infoWindow: InfoWindow(
                        title: state.companyEntity.name,
                        snippet: state.companyEntity.address,
                      ),
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: PolylineId(companyEntity.id.toString()),
                      color: AppColors.primary,
                      width: 5,
                      points: [
                        LatLng(myLocation.latitude, myLocation.longitude),
                        LatLng(companyEntity.latitude, companyEntity.longitude),
                      ],
                    ),
                  },
                );
              }
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        );
      },
      bloc: BlocProvider.of<MyCompanyBloc>(context),
      buildWhen: (previous, current) => true,
    );
  }
}
