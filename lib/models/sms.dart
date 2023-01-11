const String tableSms = 'sms';
const String tableBlockedSenders = 'blockedsenders';
const String blockedSenderName = 'sender';

class SMSFields {
  static final List<String> values = [id, sender, body, time, added];
  static const String id = '_id';
  static const String sender = 'sender';
  static const String body = 'body';
  static const String time = 'time';
  static const String added = 'added';
}

class SMS {
  final int? id;
  final String sender;
  final String body;
  final DateTime time;
  bool added;

  SMS(
      {this.id,
      required this.sender,
      required this.body,
      required this.time,
      this.added = false});

  Map<String, Object?> toJson() {
    return {
      SMSFields.id: id,
      SMSFields.sender: sender,
      SMSFields.body: body,
      SMSFields.time: time.toIso8601String(),
      SMSFields.added: added.toString(),
    };
  }

  SMS copy({
    int? id,
    String? sender,
    String? body,
    DateTime? time,
    bool? added,
  }) =>
      SMS(
        id: id ?? this.id,
        sender: sender ?? this.sender,
        body: body ?? this.body,
        time: time ?? this.time,
        added: added ?? this.added,
      );

  static SMS fromJson(Map<String, dynamic> json) => SMS(
        id: json[SMSFields.id] as int?,
        sender: json[SMSFields.sender] as String,
        body: json[SMSFields.body] as String,
        time: DateTime.parse(json[SMSFields.time] as String),
        added: json[SMSFields.added] as String == 'false' ? false : true,
      );
}
