
// format the string
String addNewLineAfterChars(String text, int charCount) {
  List<String> words = text.split('_');

  StringBuffer buffer = StringBuffer();
  int count = 0;

  for (String word in words) {
    if (count + word.length > charCount) {
      buffer.write('\n');
      count = 0;
    }

    buffer.write(word);
    count += word.length;
    if (count < charCount && words.indexOf(word) != words.length - 1) {
      buffer.write(' ');
      count++;
    }
  }

  return buffer.toString();
}


