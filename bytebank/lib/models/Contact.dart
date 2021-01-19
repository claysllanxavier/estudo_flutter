class Contact {
  final String name;
  final int accountNumber;

  Contact(this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contato(nome: $name, telefone: $accountNumber)';
  }
}
