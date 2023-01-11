const String tableBlockedSenders = 'blockedsenders';

class BlockedSenderFields {
  static final List<String> values = [id, sender];
  static const String id = '_id';
  static const String sender = 'sender';
}

class BlockedSender {
  final int? id;
  final String sender;

  BlockedSender({this.id, required this.sender});

  Map<String, Object?> toJson() {
    return {
      BlockedSenderFields.id: id,
      BlockedSenderFields.sender: sender,
    };
  }

  BlockedSender copy({
    int? id,
    String? sender,
  }) =>
      BlockedSender(
        id: id ?? this.id,
        sender: sender ?? this.sender,
      );

  static BlockedSender fromJson(Map<String, dynamic> json) => BlockedSender(
        id: json[BlockedSenderFields.id] as int?,
        sender: json[BlockedSenderFields.sender] as String,
      );
}
