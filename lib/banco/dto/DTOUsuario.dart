class DTOUsuario{
  String? id;
  String? nome;
  String? email;
  String? senha;
  String? dataNascimento;
  String? fotoPerfil;

  DTOUsuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.dataNascimento,
    this.fotoPerfil,
  });

factory DTOUsuario.fromMap(Map<String, dynamic> map) {
    return DTOUsuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      fotoPerfil: map['url_foto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'url_foto': fotoPerfil,
    };
  }

  factory DTOUsuario.fromJson(Map<String, dynamic> json, String id) {
    return DTOUsuario(
      id: id,
      nome: json['nome'],
      email: json['email'],
      fotoPerfil: json['url_foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'url_foto': fotoPerfil,
    };
  }

}