import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'dart:async';
import 'package:hotel/src/core/themes/app_fonts.dart';

import 'package:hotel/src/features/dashboard/presentation/bloc/dashboard_summary_page_cubit.dart';
enum OperationType { upload, download }

class UnifiedProgressPage extends StatefulWidget {
  final String? requestId;
  final OperationType operationType;

  const UnifiedProgressPage({
    super.key,
    this.requestId,
    required this.operationType,
  });

  @override
  State<UnifiedProgressPage> createState() => _UnifiedProgressPageState();
}

class _UnifiedProgressPageState extends State<UnifiedProgressPage>
    with SingleTickerProviderStateMixin {
  DatabaseReference? _progressRef;
  StreamSubscription<DatabaseEvent>? _subscription;
  Map<String, dynamic>? _progressData;
  bool _isListening = false;
  int _currentStep = 0;

  // Add these variables for timeout tracking
  Timer? _timeoutTimer;
  DateTime? _requestCreatedTime;
  bool _hasLoggedTimeout = false;
  String? _lastStage;
  bool _showTimeoutWarning = false;
  String _timeoutMessage = '';

  // Add this flag to prevent multiple completion calls
  bool _hasCompletionBeenCalled = false;

  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _startListening();
  }

  // Add your completion function here
  void _onOperationCompleted(String status, Map<String, dynamic> progressData) {
    print('=== OPERATION COMPLETED ===');
    print('Status: $status');
    print('Operation Type: ${widget.operationType.name}');
    print('Request ID: ${widget.requestId}');
    print('Final Progress Data: $progressData');
    print('Completion Time: ${DateTime.now()}');
    print('==========================');

    // Add your custom logic here
    switch (status) {
      case 'completed':
      case 'completed_with_extraction':
        _handleSuccessfulCompletion(progressData);
        break;
      case 'completed_with_extraction_error':
        _handleCompletionWithWarning(progressData);
        break;
      case 'failed':
      case 'error':
      case 'network_error':
      case 'download_failed':
        _handleFailedCompletion(progressData);
        break;
      default:
        print('Unknown completion status: $status');
    }
  }

  void _handleSuccessfulCompletion(Map<String, dynamic> progressData) {
    // Example: Show success dialog
    _showCompletionDialog(
      title: '${widget.operationType.name.toUpperCase()} Successful',
      message: 'Your ${widget.operationType.name} operation has been completed successfully.',
      isSuccess: true,

    );
  }

  void _handleCompletionWithWarning(Map<String, dynamic> progressData) {

    _showCompletionDialog(
      title: '${widget.operationType.name.toUpperCase()} Completed with Issues',
      message: 'Your ${widget.operationType.name} operation completed but there were some extraction issues.',
      isSuccess: false,
      isWarning: true,
    );
  }

  void _handleFailedCompletion(Map<String, dynamic> progressData) {
    print('❌ Operation failed');

    _showCompletionDialog(
      title: '${widget.operationType.name.toUpperCase()} Failed',
      message: 'Your ${widget.operationType.name} operation could not be completed. Please try again.',
      isSuccess: false,
    );
  }

  void _showCompletionDialog({
    required String title,
    required String message,
    required bool isSuccess,
    bool isWarning = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : (isWarning ? Icons.warning : Icons.error),
                color: isSuccess ? Colors.green : (isWarning ? Colors.orange : Colors.red),
                size: 28,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.interStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: AppFonts.interStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (mounted) {
                  context.read<DashboardSummaryPageCubit>().getDashboardSummaryPage(params: DashboardSummaryPageRequestParams());
                  Navigator.of(context).pop(isSuccess);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _startListening() {
    String path = widget.operationType == OperationType.upload
        ? 'db_fetch_requests/${widget.requestId}'
        : 'uploaded_files/server_to_client/download_status';

    _progressRef = FirebaseDatabase.instance.ref(path);

    // Use StreamSubscription for proper cleanup
    _subscription = _progressRef!.onValue.listen((event) {
      // Check if widget is still mounted before calling setState
      if (!mounted) return;

      if (event.snapshot.exists) {
        final newData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>
        );

        final newStepIndex = _getCurrentStepIndex(newData['stage'] ?? 'unknown');
        final currentStatus = newData['status'] ?? 'processing';
        final currentStage = newData['stage'] ?? 'unknown';

        // Debug: Always print the current data to understand the structure
        print('Firebase data received: $newData');
        print('Current stage: $currentStage, Current status: $currentStatus');
        print('Current step index: $newStepIndex, Last stage: $_lastStage');

        // *** CHECK FOR COMPLETION AND CALL FUNCTION ***
        if (_isCompleted(currentStatus) && !_hasCompletionBeenCalled) {
          _hasCompletionBeenCalled = true; // Prevent multiple calls

          // Call the completion function
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onOperationCompleted(currentStatus, newData);
          });
        }

        // Handle stage change detection and timeout monitoring
        if (_lastStage != currentStage) {
          print('Stage changed from $_lastStage to $currentStage');
          _lastStage = currentStage;
        }

        // Start timeout timer on first data received (regardless of stage)
        if (_requestCreatedTime == null) {
          _requestCreatedTime = DateTime.now();
          _startTimeoutTimer();
        }

        // Cancel timeout timer if we progress beyond the first step
        if (newStepIndex > 0 && _timeoutTimer != null) {
          _timeoutTimer!.cancel();
          _timeoutTimer = null;
          if (mounted) {
            setState(() {
              _showTimeoutWarning = false; // Hide warning when progressing
            });
          }
          print('Request progressed to step $newStepIndex, timeout timer cancelled');
        }

        // Only call setState if widget is still mounted
        if (mounted) {
          setState(() {
            _progressData = newData;
            // Don't go backwards if we're completed
            if (currentStatus == 'completed' ||
                currentStatus == 'completed_with_extraction' ||
                currentStatus == 'completed_with_extraction_error') {
              _currentStep = _getMaxStepIndex(); // Force to last step when completed
            } else if (newStepIndex > _currentStep) {
              _currentStep = newStepIndex; // Only move forward
            }
          });

          // Auto scroll to current step
          _autoScrollToStep(_currentStep);

          // Trigger animation
          _animationController.forward();
        }
      }
    });

    setState(() {
      _isListening = true;
    });
  }

  // Helper method to check if operation is completed
  bool _isCompleted(String status) {
    return status == 'completed' ||
        status == 'completed_with_extraction' ||
        status == 'completed_with_extraction_error' ||
        status == 'failed' ||
        status == 'error' ||
        status == 'network_error' ||
        status == 'download_failed';
  }

  void _startTimeoutTimer() {
    print('Starting 10-second timeout timer...');
    _timeoutTimer = Timer(Duration(seconds: 10), () {
      if (!_hasLoggedTimeout && _requestCreatedTime != null) {
        final now = DateTime.now();
        final elapsedSeconds = now.difference(_requestCreatedTime!).inSeconds;
        final currentStage = _progressData?['stage'] ?? 'unknown';
        final currentStep = _currentStep;

        print('=== TIMEOUT ERROR ===');
        print('ERROR: Request has been stuck for $elapsedSeconds seconds (exceeds 10 second limit)');
        print('Request ID: ${widget.requestId}');
        print('Operation Type: ${widget.operationType.name}');
        print('Created at: $_requestCreatedTime');
        print('Current time: $now');
        print('Current stage: $currentStage');
        print('Current step: $currentStep');
        print('Last known stage: $_lastStage');
        print('Full progress data: $_progressData');
        print('===================');

        _hasLoggedTimeout = true;

        // Show UI warning to user
        if (mounted) {
          setState(() {
            _showTimeoutWarning = true;
            _timeoutMessage = 'Request has been stuck at "$currentStage" stage for $elapsedSeconds seconds. Server may be down or experiencing issues.';
          });
          print('Showing timeout warning to user: $_timeoutMessage');
        }
      }
    });
  }

  void _autoScrollToStep(int stepIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final double targetPosition = stepIndex * 120.0; // Approximate height per step
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final scrollPosition = (targetPosition - 200).clamp(0.0, maxScrollExtent);

        _scrollController.animateTo(
          scrollPosition,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  int _getCurrentStepIndex(String stage) {
    if (widget.operationType == OperationType.upload) {
      final stages = [
        'request_created',
        'searching_file',
        'file_found',
        'creating_backup',
        'compressing',
        'uploading',
        'completed'
      ];

      final index = stages.indexOf(stage);
      if (stage == 'completed' || stage == 'upload_successful') {
        return stages.length - 1;
      }
      return index >= 0 ? index : 0;
    } else {
      // Download stages
      final stages = [
        'download_started',
        'checking_existing_file',
        'creating_backup',
        'downloading',
        'checking_compression',
        'extracting',
        'completed'
      ];

      final index = stages.indexOf(stage);
      if (stage == 'completed' || stage == 'completed_with_extraction' || stage == 'completed_with_error') {
        return stages.length - 1;
      }
      return index >= 0 ? index : 0;
    }
  }

  int _getMaxStepIndex() {
    return widget.operationType == OperationType.upload ? 6 : 6; // Both have 7 steps (0-6)
  }

  @override
  void dispose() {
    // Cancel the timeout timer when disposing
    _timeoutTimer?.cancel();

    // Cancel the Firebase subscription to prevent memory leaks
    _subscription?.cancel();

    _animationController.dispose();
    _scrollController.dispose();

    // Note: No need to call _progressRef?.onDisconnect() since we're using subscription
    super.dispose();
  }

  // Rest of your existing build method and other methods remain the same...
  @override
  Widget build(BuildContext context) {
    if (!_isListening) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(_getOperationTitle()),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_progressData == null) {
      return _buildWaitingState();
    }

    final String status = _progressData!['status'] ?? 'processing';
    final String currentMessage = _progressData!['message'] ?? 'Processing...';
    final int progress = _progressData!['progress'] ?? 0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const AppBarIosBackButton(color: Colors.black87),
        title: Text(
          _getOperationTitle(),
          style: AppFonts.interStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Timeout Warning Banner - Show when request is stuck
          if (_showTimeoutWarning)
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[300]!, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange[700],
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connection Issue Detected',
                          style: AppFonts.interStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _timeoutMessage,
                          style: AppFonts.interStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showTimeoutWarning = false;
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.orange[700],
                      size: 18,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),

          // Progress Header - Made Smaller
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(12, _showTimeoutWarning ? 8 : 12, 12, 0),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getStatusIcon(status),
                        size: 24,
                        color: _getStatusColor(status),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getStatusTitle(status),
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '$progress% Complete',
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          // Current Message - Collapsible (with conditional styling for timeout)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(_isStatusCompleted(status) ? 8 : 12),
            decoration: BoxDecoration(
              color: _showTimeoutWarning
                  ? Colors.orange[50]
                  : (_isStatusCompleted(status) ? Colors.green[50] : Colors.blue[50]),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _showTimeoutWarning
                    ? Colors.orange[200]!
                    : (_isStatusCompleted(status) ? Colors.green[200]! : Colors.blue[200]!),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _showTimeoutWarning
                      ? Icons.warning_outlined
                      : (_isStatusCompleted(status) ? Icons.check_circle : Icons.info_outline),
                  color: _showTimeoutWarning
                      ? Colors.orange[700]
                      : (_isStatusCompleted(status) ? Colors.green[700] : Colors.blue[700]),
                  size: _isStatusCompleted(status) ? 14 : 16,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 300),
                    style: AppFonts.interStyle(
                      fontSize: _isStatusCompleted(status) ? 12 : 13,
                      fontWeight: FontWeight.w500,
                      color: _showTimeoutWarning
                          ? Colors.orange[800]
                          : (_isStatusCompleted(status) ? Colors.green[800] : Colors.blue[800]),
                    ),
                    child: Text(
                      _showTimeoutWarning
                          ? 'Connection timeout - please check server status'
                          : currentMessage,
                      maxLines: _isStatusCompleted(status) ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Beautiful Vertical Steps - More Space
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress Steps',
                    style: AppFonts.interStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: BeautifulVerticalSteps(
                        currentStep: _currentStep,
                        status: status,
                        animationController: _animationController,
                        progressData: _progressData,
                        operationType: widget.operationType,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer Info - Smaller with formatted time
          if (_progressData!.containsKey('last_updated'))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                  SizedBox(width: 6),
                  Text(
                    'Last updated: ${_formatTimestamp(_progressData!['last_updated'])}',
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWaitingState() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const AppBarIosBackButton(color: Colors.black87),
        title: Text(_getOperationTitle()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.operationType == OperationType.upload
                    ? Icons.cloud_upload_outlined
                    : Icons.cloud_download_outlined,
                size: 50,
                color: Colors.blue[400],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Waiting for ${widget.operationType.name} to start...',
              style: AppFonts.interStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your request is being processed',
              style: AppFonts.interStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getOperationTitle() {
    return widget.operationType == OperationType.upload
        ? 'Database Upload to Server'
        : 'Database Download From Server';
  }

  bool _isStatusCompleted(String status) {
    return status == 'completed' ||
        status == 'completed_with_extraction' ||
        status == 'completed_with_extraction_error';
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'completed_with_extraction':
        return Icons.check_circle_outline;
      case 'completed_with_extraction_error':
        return Icons.warning_outlined;
      case 'failed':
      case 'error':
      case 'network_error':
      case 'download_failed':
        return Icons.error_outline;
      case 'not_found':
        return Icons.search_off;
      default:
        return widget.operationType == OperationType.upload
            ? Icons.cloud_upload_outlined
            : Icons.cloud_download_outlined;
    }
  }

  String _getStatusTitle(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'completed_with_extraction':
        return '${widget.operationType.name.toUpperCase()} Completed Successfully';
      case 'completed_with_extraction_error':
        return '${widget.operationType.name.toUpperCase()} Completed with Issues';
      case 'failed':
      case 'error':
        return '${widget.operationType.name.toUpperCase()} Failed';
      case 'network_error':
        return 'Network Error';
      case 'download_failed':
        return 'Download Failed';
      case 'not_found':
        return 'File Not Found';
      default:
        return 'Processing Database ${widget.operationType.name.toUpperCase()}';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'completed_with_extraction':
        return Colors.green[600]!;
      case 'completed_with_extraction_error':
        return Colors.orange[600]!;
      case 'failed':
      case 'error':
      case 'network_error':
      case 'download_failed':
        return Colors.red[600]!;
      case 'not_found':
        return Colors.orange[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();

      // Format to "Jul 26 - 6:00 PM" style
      final month = _getMonthAbbr(dateTime.month);
      final day = dateTime.day;
      final hour = dateTime.hour;
      final minute = dateTime.minute;

      // Convert to 12-hour format
      String period = hour >= 12 ? 'PM' : 'AM';
      int displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

      String formattedTime = '${displayHour}:${minute.toString().padLeft(2, '0')} $period';

      // If same day, just show time, otherwise show date + time
      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        return formattedTime;
      } else {
        return '$month $day - $formattedTime';
      }
    } catch (e) {
      return timestamp;
    }
  }

  String _getMonthAbbr(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}

// BeautifulVerticalSteps class remains the same as in your original code...

class BeautifulVerticalSteps extends StatelessWidget {
  final int currentStep;
  final String status;
  final AnimationController animationController;
  final Map<String, dynamic>? progressData;
  final OperationType operationType;

  const BeautifulVerticalSteps({
    Key? key,
    required this.currentStep,
    required this.status,
    required this.animationController,
    required this.operationType,
    this.progressData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isCompleted = index < currentStep ||
              (index == currentStep && _isCompleted(status)) ||
              (_isCompleted(status) && index <= 6); // All steps completed when status is completed
          final isCurrent = index == currentStep && !_isCompleted(status);
          final isFailed = _isFailed(status) && index == currentStep;
          final isLast = index == steps.length - 1;

          return AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step indicator column
                  Column(
                    children: [
                      _buildStepCircle(step, isCompleted, isCurrent, isFailed, index),
                      if (!isLast) _buildConnectorLine(isCompleted, isCurrent),
                    ],
                  ),
                  SizedBox(width: 20),
                  // Content
                  Expanded(
                    child: _buildStepContent(step, isCompleted, isCurrent, isFailed, index),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 20),
      ],
    );
  }

  bool _isCompleted(String status) {
    return status == 'completed' ||
        status == 'completed_with_extraction' ||
        status == 'completed_with_extraction_error';
  }

  bool _isFailed(String status) {
    return status == 'failed' ||
        status == 'error' ||
        status == 'network_error' ||
        status == 'download_failed';
  }

  Widget _buildStepCircle(Map<String, dynamic> step, bool isCompleted, bool isCurrent, bool isFailed, int index) {
    Color backgroundColor;
    Color borderColor;
    Widget icon;

    if (isCompleted) {
      backgroundColor = Colors.green[500]!;
      borderColor = Colors.green[500]!;
      icon = Icon(Icons.check, color: Colors.white, size: 20);
    } else if (isCurrent) {
      backgroundColor = Colors.blue[500]!;
      borderColor = Colors.blue[500]!;
      icon = SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (isFailed) {
      backgroundColor = Colors.red[500]!;
      borderColor = Colors.red[500]!;
      icon = Icon(Icons.close, color: Colors.white, size: 20);
    } else {
      backgroundColor = Colors.grey[200]!;
      borderColor = Colors.grey[300]!;
      icon = Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
      );
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: isCurrent ? [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: Center(child: icon),
    );
  }

  Widget _buildConnectorLine(bool isCompleted, bool isCurrent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: 2,
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green[500] : Colors.grey[300],
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildStepContent(Map<String, dynamic> step, bool isCompleted, bool isCurrent, bool isFailed, int index) {
    final shouldExpand = isCurrent && !_isCompleted(status);
    final currentMessage = progressData?['message'] ?? '';

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      padding: EdgeInsets.all(shouldExpand ? 16 : 12),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.blue[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isCurrent ? Border.all(color: Colors.blue[200]!, width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  step['title'],
                  style: AppFonts.interStyle(
                    fontSize: shouldExpand ? 16 : 15,
                    fontWeight: FontWeight.w600,
                    color: _getStepTextColor(isCompleted, isCurrent, isFailed),
                  ),
                ),
              ),
              _buildStepLabel(isCompleted, isCurrent, isFailed),
            ],
          ),
          SizedBox(height: shouldExpand ? 8 : 6),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 300),
            style: AppFonts.interStyle(
              fontSize: shouldExpand ? 14 : 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
            child: Text(
              step['description'],
              maxLines: shouldExpand ? 3 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isCurrent && currentMessage.isNotEmpty && shouldExpand) ...[
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[100]?.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[300]!, width: 0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    operationType == OperationType.upload ? Icons.cloud_upload : Icons.cloud_download,
                    size: 16,
                    color: Colors.blue[700],
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      currentMessage,
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepLabel(bool isCompleted, bool isCurrent, bool isFailed) {
    if (isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Completed',
          style: AppFonts.interStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.green[700],
          ),
        ),
      );
    } else if (isCurrent) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'In Progress',
          style: AppFonts.interStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.blue[700],
          ),
        ),
      );
    } else if (isFailed) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Failed',
          style: AppFonts.interStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.red[700],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Pending',
          style: AppFonts.interStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      );
    }
  }

  Color _getStepTextColor(bool isCompleted, bool isCurrent, bool isFailed) {
    if (isFailed) return Colors.red[700]!;
    if (isCompleted || isCurrent) return Colors.grey[800]!;
    return Colors.grey[500]!;
  }

  List<Map<String, dynamic>> _getSteps() {
    if (operationType == OperationType.upload) {
      return [
        {
          'title': 'Request Created',
          'description': 'Database upload request has been initiated',
          'icon': Icons.receipt_outlined,
        },
        {
          'title': 'Searching File',
          'description': 'Looking for the requested database file',
          'icon': Icons.search_outlined,
        },
        {
          'title': 'File Found',
          'description': 'Target database file has been located',
          'icon': Icons.description_outlined,
        },
        {
          'title': 'Creating Backup',
          'description': 'Creating compressed backup of existing file',
          'icon': Icons.backup_outlined,
        },
        {
          'title': 'Compressing',
          'description': 'Compressing file for efficient transfer',
          'icon': Icons.compress,
        },
        {
          'title': 'Uploading',
          'description': 'Securely uploading to destination server',
          'icon': Icons.cloud_upload_outlined,
        },
        {
          'title': 'Completed',
          'description': 'Upload operation finished successfully',
          'icon': Icons.check_circle_outline,
        },
      ];
    } else {
      return [
        {
          'title': 'Download Started',
          'description': 'Database download request has been initiated',
          'icon': Icons.play_circle_outline,
        },
        {
          'title': 'Checking Existing File',
          'description': 'Looking for existing database file to backup',
          'icon': Icons.search_outlined,
        },
        {
          'title': 'Creating Backup',
          'description': 'Creating compressed backup of existing file',
          'icon': Icons.backup_outlined,
        },
        {
          'title': 'Downloading',
          'description': 'Downloading database file from server',
          'icon': Icons.cloud_download_outlined,
        },
        {
          'title': 'Checking Compression',
          'description': 'Checking if downloaded file is compressed',
          'icon': Icons.archive_outlined,
        },
        {
          'title': 'Extracting',
          'description': 'Extracting compressed file if needed',
          'icon': Icons.unarchive_outlined,
        },
        {
          'title': 'Completed',
          'description': 'Download operation finished successfully',
          'icon': Icons.check_circle_outline,
        },
      ];
    }
  }
}