class InputValidator {
  static String _isEmpty = 'Não pode estar vazio';
  static String _minLenght(int length) =>
      'Precisa ter no mínimo ${length.toString()} caractéres';
  static String _notZeroValue = 'O produto não pode ter R\$ 0.00 de preço';
  static String _onlyNumber =
      'Preço são apenas números separados por um ponto. Exemplo: 5.99';

  static title(String value) {
    if (value.trim().isEmpty) {
      return _isEmpty;
    }
  }

  static price(String value) {
    if (value.trim().isEmpty) {
      return _isEmpty;
    }

    if (!(value.contains(RegExp(r'^(?!\.)\d*\.?\d+$')))) {
      return _onlyNumber;
    }

    if (double.parse(value) <= 0) {
      return _notZeroValue;
    }
  }

  static description(String value) {
    if (value.trim().isEmpty) {
      return _isEmpty;
    }

    if (value.trim().length < 30) {
      return _minLenght(30);
    }
  }

  static url(String value) {
    if (value.trim().isEmpty) {
      return _isEmpty;
    }

    bool http = value.toLowerCase().startsWith('http://');
    bool https = value.toLowerCase().startsWith('https://');

    if (!http && !https) {
      return 'Url inválida. Precisa começar com http:// ou https://';
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
      return 'Apenas images ${mimeTypes.join(", ")} são válidas.';
    }
  }
}
