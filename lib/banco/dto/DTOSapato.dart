class DTOSapato {
  String? id;
  String? modelo;
  String? tipo;
  String? cor;
  String? marca;
  String? fotoUrl;

  DTOSapato({
    this.id,
    this.modelo,
    this.tipo,
    this.cor,
    this.marca,
    this.fotoUrl,
  });

  
Map<String, dynamic> toMap() {
    return {
      'id': id != null ? int.tryParse(id!) : null,
      'modelo': modelo,
      'tipo': tipo,
      'cor': cor,
      'marca': marca,
      'url_foto': fotoUrl,
    };
  }

  factory DTOSapato.fromMap(Map<String, dynamic> map) {
    return DTOSapato(
      id: map['id']?.toString(),
      modelo: map['modelo'],
      tipo: map['tipo'],
      cor: map['cor'],
      marca: map['marca'],
      fotoUrl: map['url_foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelo': modelo,
      'tipo': tipo,
      'cor': cor,
      'marca': marca,
      'fotoUrl': fotoUrl,
    };
  }

  factory DTOSapato.fromJson(Map<String, dynamic> json, String id) {
    return DTOSapato(
      id: id,
      modelo: json['modelo'],
      tipo: json['tipo'],
      cor: json['cor'],
      marca: json['marca'],
      fotoUrl: json['fotoUrl'],
    );
  }
}
