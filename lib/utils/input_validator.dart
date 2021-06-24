class InputValidator {
  static title(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }
  }

  static price(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    if (!(value.contains(RegExp(r'^(?!\.)\d*\.?\d+$')))) {
      return _Messages.onlyNumber;
    }

    if (double.parse(value) <= 0) {
      return _Messages.notZeroValue;
    }
  }

  static description(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    if (value.trim().length < 10) {
      return _Messages.minLength(10);
    }
  }

  static url(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    bool http = value.toLowerCase().startsWith('http://');
    bool https = value.toLowerCase().startsWith('https://');

    if (!http && !https) {
      return _Messages.invalidUrl;
    }

    List<String> mimeTypes = [
      '.png',
      '.jpg',
      '.jpeg',
    ];

    var isValidMimeType = mimeTypes.firstWhere(
      (mimeType) => value.endsWith(mimeType),
      orElse: () => null,
    );

    if (isValidMimeType == null) {
      return _Messages.invalidMimeTypes(mimeTypes);
    }
  }

  static email(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    RegExp emailRegex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!emailRegex.hasMatch(value)) {
      return _Messages.invalidEmail;
    }

    return null;
  }

  static password(String value) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    if (value.trim().length < 5) {
      return _Messages.minLength(5);
    }

    return null;
  }

  static checkPassword(String value, String comparePassword) {
    if (value.trim().isEmpty) {
      return _Messages.isEmpty;
    }

    if (value != comparePassword) {
      return _Messages.notSamePassword;
    }

    return null;
  }
}

class _Messages {
  static String isEmpty = 'Não pode estar vazio';
  static String minLength(int length) =>
      'Precisa ter no mínimo ${length.toString()} caractéres';
  static String notZeroValue = 'O produto não pode ter R\$ 0.00 de preço';
  static String onlyNumber =
      'Preço são apenas números separados por um ponto. Exemplo: 5.99';
  static String invalidUrl =
      'Url inválida. Precisa começar com http:// ou https://';
  static String invalidEmail = 'Email inválido';
  static String notSamePassword = 'As senhas precisam ser as mesmas.';
  static String invalidMimeTypes(List<String> mimeTypes) =>
      'Apenas images ${mimeTypes.join(", ")} são válidas.';
}
