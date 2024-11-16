class Message {
  String sender;
  final String receiver;
  String content;
  DateTime timestamp;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  get unread => null;

  // Convert a Message instance to a Map. Useful for uploading data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create a Message instance from a map. Useful for reading data from Firebase
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'],
      receiver: map['receiver'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
