import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../resource/constants/app_colors.dart';
import '../resource/styles/styles.dart';
import '../view/widgets/button/custom_button.dart';
import '../view/widgets/loader/loader_widget.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionController.stream;
  bool _isDialogOpen = false;
  bool _isInternetAvailable = true; // Tracks internet availability

  void initialize(BuildContext context) {
    _checkInternetInitially(context);
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _checkInternetConnectivity(context);
    });
  }

  Future<void> _checkInternetInitially(BuildContext context) async {
    await _checkInternetConnectivity(context);
  }

  Future<void> _checkInternetConnectivity(BuildContext context) async {
    bool isConnected = await _hasInternetAccess();
    _isInternetAvailable = isConnected;
    _connectionController.add(isConnected);
    _showOrDismissPopup(context, isConnected);
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false; // No actual internet
    }
  }

  void _showOrDismissPopup(BuildContext context, bool isConnected) {
    if (!isConnected) {
      if (!_isDialogOpen) {
        _isDialogOpen = true;
        _showNoInternetDialog(context);
      }
    } else {
      if (_isDialogOpen) {
        _isDialogOpen = false;
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
  }

  void _showNoInternetDialog(BuildContext context) {
    bool isLoading = false;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: AppColors.primary,
                    size: 50,
                  ),
                  Gap(16.0),
                  const Text(
                    "No Internet Connection",
                    style: AppTextStyles.style16DarkGrey600,
                  ),
                  Gap(8.0),
                  const Text(
                    "Check your WiFi or Mobile Data.",
                    style: AppTextStyles.style14DarkGrey600,
                  ),
                  Gap(20.0),
                  StatefulBuilder(
                    builder: (context, changeState) {
                      if (isLoading == true) {
                        return LoaderWidget();
                      }
                      return CustomButton(
                        text: 'Retry',
                        invert: true,
                        onPressed: () async {
                          changeState(() {
                            isLoading = true;
                          });
                          bool hasInternet = await _hasInternetAccess();
                          changeState(() {
                            isLoading = false;
                          });
                          if (hasInternet && context.mounted) {
                            _showOrDismissPopup(context, true);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool get isInternetAvailable => _isInternetAvailable;
}
