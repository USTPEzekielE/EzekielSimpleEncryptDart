import 'dart:io';

void main() {
  bool exitProgram = false;
  
  // Option Menu
  while (!exitProgram) {
    print('Choose operation:');
    print('1. Encode');
    print('2. Decode');
    print('3. Close program');

    int choice;
    try {
      choice = int.parse(stdin.readLineSync() ?? '0');

      // Validate user's choice
      if (choice < 1 || choice > 3) {
        print('Invalid choice. Please enter a valid option (1, 2, or 3).');
        continue;
      }
    } catch (_) {
      print('Invalid input. Please enter a valid option (1, 2, or 3).');
      continue;
    }

    // Closes the program if the user choose 3
    if (choice == 3) {
      print('Closing the program. Goodbye!');
      break;
    }

    // Read the user's input
    print('Enter the text:');
    String inputText = stdin.readLineSync()?.trim() ?? '';
    if (inputText.isEmpty) {
      print('Error: Text input cannot be empty.');
      continue;
    }

    // Read and parse the user's shift value
    int shift;
    try {
      print('Enter the shift value for the Caesar Cipher:');
      shift = int.parse(stdin.readLineSync() ?? '0');
    } catch (_) {
      print('Invalid input. Returning to menu.');
      continue;
    }

    // Perform the Caesar Cipher operation
    String result;
    if (choice == 1) {
      // Encodes the text
      result = caesarCipher(inputText, shift, true);
    } else if (choice == 2) {
      // Decodes the text
      result = caesarCipher(inputText, shift, false);
    } else {
      // Prints error message if invalid input
      print('Invalid choice. Please choose 1 for encoding, 2 for decoding, or 3 to close the program.');
      continue;
    }

    // Display the result of the operation
    print('\nResult: $result');
    
    // Asks the user if they want to perform another operation
    print('\nDo you want to perform another operation? (Type "close" to exit, anything else to continue)');
    String continueOption = stdin.readLineSync()?.toLowerCase() ?? '';
    if (continueOption == 'close') {
      exitProgram = true;
      print('Closing the program. Goodbye!');
    }
  }
}

// Function to perform Caesar Cipher operation
String caesarCipher(String text, int shift, bool encode) {
  // Function to shift a single character
  String Function(String, int) shiftCharacter = (char, shift) {
    final int lowerA = 'a'.codeUnitAt(0);
    final int upperA = 'A'.codeUnitAt(0);

    String result = char;

    // Shift alphabetic characters
    if (char.contains(RegExp(r'[a-zA-Z]'))) {
      int shiftedCharCode = (char.codeUnitAt(0) + shift - (char.contains(RegExp(r'[a-z]')) ? lowerA : upperA)) % 26 + (char.contains(RegExp(r'[a-z]')) ? lowerA : upperA);
      result = String.fromCharCode(shiftedCharCode);
    }

    return result;
  };

  // Map each character in the input to its shifted counterpart
  return String.fromCharCodes(text.runes.map((rune) {
    String currentChar = String.fromCharCode(rune);
    return shiftCharacter(currentChar, encode ? shift : -shift).codeUnitAt(0);
  }));
}
