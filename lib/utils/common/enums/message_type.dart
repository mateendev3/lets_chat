enum MessageType {
  text('text'),
  image('image'),
  gif('gif'),
  audio('audio'),
  video('video');

  final String type;
  const MessageType(this.type);
}

extension ConvertMessageType on String {
  MessageType toEnum() {
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'gif':
        return MessageType.gif;
      case 'audio':
        return MessageType.audio;
      case 'video':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }
}
