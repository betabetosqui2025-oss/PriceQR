import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'q_r_verification_model.dart';
export 'q_r_verification_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class QRVerificationWidget extends StatefulWidget {
  const QRVerificationWidget({super.key});

  static String routeName = 'QRVerification';
  static String routePath = '/qRVerification';

  @override
  State<QRVerificationWidget> createState() => _QRVerificationWidgetState();
}

class _QRVerificationWidgetState extends State<QRVerificationWidget> {
  late QRVerificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final MobileScannerController _cameraController = MobileScannerController();
    bool _isProcessing = false;


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QRVerificationModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/QR_Verification.png',
              ).image,
            ),
          ),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 11.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'assets/images/Button.png',
                              width: 200.0,
                              height: 77.6,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
  width: double.infinity,
  height: MediaQuery.sizeOf(context).height * 0.65,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: MobileScanner(
    onDetect: (capture) async {
  if (_isProcessing) return; // evita múltiples lecturas rápidas
  _isProcessing = true;

  final List<Barcode> barcodes = capture.barcodes;
  for (final barcode in barcodes) {
    final value = barcode.rawValue ?? '';
    debugPrint('Código detectado: $value');

    if (value.isEmpty) continue;

    // Verifica si el QR contiene un enlace de imagen
    final isImageUrl = value.endsWith('.jpg') ||
        value.endsWith('.jpeg') ||
        value.endsWith('.png') ||
        value.endsWith('.gif') ||
        value.contains('data:image');

    if (isImageUrl) {
      // Muestra modal con la imagen
  await showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) {
    bool isFullScreen = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          insetPadding: isFullScreen
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          backgroundColor:
              Colors.black.withOpacity(isFullScreen ? 1.0 : 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isFullScreen ? 0 : 20),
          ),
          child: Stack(
            children: [
              // Imagen (toca para ampliar o reducir)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFullScreen = !isFullScreen;
                  });
                },
                child: InteractiveViewer(
                  child: Image.network(
                    value,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'No se pudo cargar la imagen 😢',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Botón de cerrar (la X)
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  },
);

    } else {
      // Si no es imagen, solo mostrar texto como antes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR: $value')),
      );
    }
  }

  // Espera un momento antes de permitir nuevo escaneo
  await Future.delayed(const Duration(seconds: 2));
  _isProcessing = false;
},

  ),
),

                    ),
                    Text(
                      'Place an QR at the center of your camera and the QR will be automatically scanned',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.karla(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6D6D6D),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
