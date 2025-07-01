class ScriptSQLite {
  // ===== COMANDOS DE CRIAÇÃO DE TABELAS =====

  static const String _criarTabelaUsuario = '''
    CREATE TABLE usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL,
      url_foto TEXT
    )
  ''';

  static const String _criarTabelaRoupa = '''
    CREATE TABLE roupa (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      modelo TEXT NOT NULL,
      tipo TEXT,
      cor TEXT,
      marca TEXT,
      url_foto TEXT
    )
  ''';

  static const String _criarTabelaSapato = '''
    CREATE TABLE sapato (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      modelo TEXT NOT NULL,
      tipo TEXT,
      cor TEXT,
      marca TEXT,
      url_foto TEXT
    )
  ''';

  static const String _criarTabelaAcessorio = '''
    CREATE TABLE acessorio (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      tipo TEXT,
      cor TEXT,
      marca TEXT,
      url_foto TEXT
    )
  ''';

  // Tabela Look SEM a coluna id_usuario
  static const String _criarTabelaLook = '''
    CREATE TABLE look (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL
    )
  ''';
  
  static const String _criarTabelaLookItem = '''
    CREATE TABLE look_item (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_look INTEGER NOT NULL,
      id_item INTEGER NOT NULL,
      tipo_item TEXT NOT NULL, -- 'roupa', 'sapato', 'acessorio'
      FOREIGN KEY (id_look) REFERENCES look(id)
    )
  ''';

  static const String _criarTabelaEvento = '''
    CREATE TABLE evento (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      data TEXT,
      id_look INTEGER,
      FOREIGN KEY (id_look) REFERENCES look(id)
    )
  ''';

  // Variável pública com todos os comandos de criação
  static const List<String> comandosCriarTabelas = [
    _criarTabelaUsuario,
    _criarTabelaRoupa,
    _criarTabelaSapato,
    _criarTabelaAcessorio,
    _criarTabelaLook,
    _criarTabelaLookItem,
    _criarTabelaEvento,
  ];

  // ===== COMANDOS DE INSERÇÃO =====

  static const List<String> _insercoesUsuario = [
    "INSERT INTO usuario (nome, email, senha) VALUES ('Laryssa', 'lary@email.com', '123')",
  ];

  static const List<String> _insercoesRoupa = [
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Calça Jeans', 'Calça', 'Azul', 'Levi''s', 'https://i.imgur.com/8k9MFl7.png')",
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Camiseta Branca', 'Camiseta', 'Branca', 'Hering', 'https://i.imgur.com/7pW33pW.png')",
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Vestido Preto', 'Vestido', 'Preto', 'Zara', 'https://i.imgur.com/Oin4zGe.png')",
  ];

  static const List<String> _insercoesSapato = [
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Tênis Branco', 'Tênis', 'Branco', 'Nike', 'https://i.imgur.com/Kv6q26y.png')",
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Salto Alto Preto', 'Salto', 'Preto', 'Arezzo', 'https://i.imgur.com/rD9d6aD.png')",
  ];

  static const List<String> _insercoesAcessorio = [
    "INSERT INTO acessorio (nome, tipo, cor, marca, url_foto) VALUES ('Bolsa de Couro', 'Bolsa', 'Marrom', 'Schutz', 'https://i.imgur.com/4zL9ZmP.png')",
    "INSERT INTO acessorio (nome, tipo, cor, marca, url_foto) VALUES ('Óculos de Sol', 'Óculos', 'Preto', 'Ray-Ban', 'https://i.imgur.com/O6Gq3bL.png')",
  ];
  
  // Inserções na tabela Look SEM a coluna id_usuario
  static const List<String> _insercoesLook = [
    "INSERT INTO look (nome) VALUES ('Look Casual')",
    "INSERT INTO look (nome) VALUES ('Look de Festa')",
  ];

  static const List<String> _insercoesLookItem = [
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 1, 'roupa')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 2, 'roupa')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 1, 'sapato')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 2, 'acessorio')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 3, 'roupa')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 2, 'sapato')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 1, 'acessorio')",
  ];

  static const List<String> _insercoesEvento = [
    "INSERT INTO evento (nome, data, id_look) VALUES ('Aniversário da Maria', '2025-07-15', 2)",
    "INSERT INTO evento (nome, data, id_look) VALUES ('Passeio no Parque', '2025-08-01', 1)",
  ];

  static const List<List<String>> comandosInsercoes = [
    _insercoesUsuario,
    _insercoesRoupa,
    _insercoesSapato,
    _insercoesAcessorio,
    _insercoesLook,
    _insercoesLookItem,
    _insercoesEvento,
  ];
}
