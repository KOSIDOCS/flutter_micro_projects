RegExp passRegex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

RegExp passSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

RegExp passNumber = RegExp(r'[0-9]');
