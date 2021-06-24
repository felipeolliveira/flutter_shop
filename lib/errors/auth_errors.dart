class AuthErrors implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email já existe.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Muitas requisições. Espere um minuto e tente novamente.',
    'EMAIL_NOT_FOUND': 'Email ou Senha inválidos',
    'INVALID_PASSWORD': 'Email ou Senha inválidos',
    'USER_DISABLED': 'Usuário desativado. Entre em contato com o suporte.',
  };

  final String key;

  const AuthErrors(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    }

    return 'Ocorreu um erro na autenticação!';
  }
}
