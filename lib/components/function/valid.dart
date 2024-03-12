import '../constant/messages.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) return messageInputEmpty;
  if (val.length > max) return "$messageInputMax $max";
  if (val.length < min) return "$messageInputMin $min";
  return null;
}
