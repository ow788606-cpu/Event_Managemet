import '../models/event_model.dart';

enum ServiceStatus { pending, inProgress, completed, cancelled }

class ServiceRequest {
  final String requestId;
  final Event service;
  final String serviceType;
  final DateTime requestDate;
  final String notes;
  ServiceStatus status;

  ServiceRequest({
    required this.requestId,
    required this.service,
    required this.serviceType,
    required this.requestDate,
    required this.notes,
    required this.status,
  });
}

class ServicesManager {
  static final List<ServiceRequest> _requests = [];
  static int _requestCounter = 1000;

  static List<ServiceRequest> getRequests() => List.unmodifiable(_requests);

  static String addRequest(Event service, String serviceType, String notes) {
    final requestId = 'SR${_requestCounter++}';
    final request = ServiceRequest(
      requestId: requestId,
      service: service,
      serviceType: serviceType,
      requestDate: DateTime.now(),
      notes: notes,
      status: ServiceStatus.pending,
    );
    _requests.insert(0, request);
    return requestId;
  }

  static void cancelRequest(String requestId) {
    final request = _requests.firstWhere((r) => r.requestId == requestId);
    request.status = ServiceStatus.cancelled;
  }

  static void updateStatus(String requestId, ServiceStatus status) {
    final request = _requests.firstWhere((r) => r.requestId == requestId);
    request.status = status;
  }
}
