import 'package:flutter/services.dart';

String? validateNotNull(String? value, String validateContent) {
  if (value == null || value.isEmpty) {
    return 'Please enter the $validateContent';
  }
  return null; // Return null if the input is valid
}

String? validateName(String? value, String label, int length) {
  if (value == null || value.isEmpty) {
    return 'Please enter the $label';
  }

  if (value.length < length) {
    return 'Please enter valid $label';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the address';
  }

  if (value.length < 10) {
    return 'Please enter valid address';
  }
  return null;
}

String? validatePalce(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the palce';
  }

  if (value.length < 4) {
    return 'Please enter valid place';
  }
  return null;
}

String? validateProofNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the Proof No';
  }

  if (value.length < 4) {
    return 'Please enter valid Proof No';
  }
  return null;
}

String? validatePrcentage(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the Proof No';
  }

  if (value.length < 4) {
    return 'Please enter valid Proof No';
  }
  return null;
}

String? mobileNumberValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Mobile Number';
  }
  if (value.length != 10) {
    return 'Please enter valid Mobile Number';
  } else if (int.parse(value.substring(0, 1)) <= 5) {
    return 'Please enter valid Mobile Number';
  }
  return null;
}

String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Email Id';
  }
  if (!RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  ).hasMatch(value)) {
    return 'Please enter valid Email Id';
  }
  return null;
}

// String? validateName(String? value) {
//   if (value!.isEmpty) {
//     return 'Please enter your name.';
//   } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//     return 'Name can only contain alphabets.';
//   }
//   return null;
// }

// String? validatePhoneNumber(String? value) {
//   if (value == null || value.isEmpty) {
//     return "Please enter phone number";
//   }
//   if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//     return 'Please enter a valid phone number';
//   }
//   return null;
// }

String? validatePinCode(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter pinCode";
  }
  if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
    return 'Please enter a valid pinCode';
  }
  return null;
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter an email address.';
  } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
      .hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

// String? validateProofNumber(String? value, String selectedIdentityProof) {
//   if (value == null || value.isEmpty) {
//     return 'Proof Number is required';
//   }

//   RegExp regex;

//   switch (selectedIdentityProof) {
//     case 'aadhar':
//       regex = RegExp(r'^\d{12}$');
//       break;
//     case 'passport':
//       regex = RegExp(r'^[a-zA-Z0-9]{6,}$');
//       break;
//     case 'pancard':
//       regex = RegExp(r'^[a-zA-Z0-9]{8,10}$');
//       break;
//     case 'voterid':
//       regex = RegExp(r'^[a-zA-Z0-9]{10}$');
//       break;
//     default:
//       return 'Invalid proof number';
//   }

//   if (!regex.hasMatch(value)) {
//     return 'Invalid $selectedIdentityProof number';
//   }

//   return null;
// }

String? validatePercentage(value) {
  try {
    int percentage = int.parse(value);
    if (percentage < 0 || percentage > 100) {
      return 'Enter a percentage between 0 and 100';
    }
  } catch (e) {
    return 'Enter a valid percentage';
  }
  return null;
}

String? validatePanCard(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your PAN Number';
  }
  final RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  if (!panRegex.hasMatch(value.toUpperCase())) {
    return 'Invalid PAN Number';
  }
  return null;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.toUpperCase() == newValue.text) {
      return newValue;
    } else {
      return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
    }
  }
}

// class NoSapceInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.contains(' ')) {
//       return oldValue;
//     }
//     return newValue;
//   }
// }

// class NoSpecialCharactersFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Remove special characters from the new value
//     final sanitizedValue = newValue.text.replaceAll(RegExp(r'[^\w\s]'), '');

//     return TextEditingValue(
//       text: sanitizedValue,
//       selection: newValue.selection,
//     );
//   }
// }
