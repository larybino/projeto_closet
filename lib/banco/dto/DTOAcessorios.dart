class DTOAcessorios {
  String? id;
  String? modelo;
  String? tipo;
  String? cor;
  String? marca;
  String? fotoUrl;

  DTOAcessorios({
    this.id,
    this.modelo,
    this.tipo,
    this.cor,
    this.marca,
    this.fotoUrl,
  });

  
  factory DTOAcessorios.fromMap(Map<String, dynamic> map) {
    return DTOAcessorios(
      id: map['id']?.toString(),
      modelo: map['modelo'],
      tipo: map['tipo'],
      cor: map['cor'],
      marca: map['marca'],
      fotoUrl: map['url_foto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modelo': modelo,
      'tipo': tipo,
      'cor': cor,
      'marca': marca,
      'url_foto': fotoUrl,
    };
  }

  factory DTOAcessorios.fromJson(Map<String, dynamic> json, String id) {
    return DTOAcessorios(
      id: id,
      modelo: json['modelo'],
      tipo: json['tipo'],
      cor: json['cor'],
      marca: json['marca'],
      fotoUrl: json['url_foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelo': modelo,
      'tipo': tipo,
      'cor': cor,
      'marca': marca,
      'url_foto': fotoUrl,
    };
  }
}
