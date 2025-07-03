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
      modelo TEXT NOT NULL,
      tipo TEXT,
      cor TEXT,
      marca TEXT,
      url_foto TEXT
    )
  ''';

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
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Vestido Floral', 'Vestido', 'Multicolorido', 'Farm', 'https://lojafarm.vteximg.com.br/arquivos/ids/3411470/331280_49147_1-VESTIDO-LONGO-FLORAL-DE-VERAO.jpg?v=638590753519000000')",
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Camiseta FARM Reta Paisagem Ipanema Branca', 'Camiseta', 'Branca', 'Farm', 'https://t-static.dafiti.com.br/_GwrkZhGcP0r-qeVdrRqc4YNuk4=/fit-in/430x623/static.dafiti.com.br/p/farm-camiseta-farm-reta-paisagem-ipanema-branca-3413-59553641-1-zoom.jpg')",
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Blusa', 'Blusa', 'Cinza', 'Hering', 'https://cdnv2.moovin.com.br/iriacalcados/imagens/produtos/det/blusa-hering-k4wf1asi-verde-militar-927227b8687330d849d6737f1332e755.jpg')",
    "INSERT INTO roupa (modelo, tipo, cor, marca, url_foto) VALUES ('Vestido de tricô plissado', 'Vestido', 'Vermelho', 'Balmain', 'https://cdn11.bigcommerce.com/s-2w3d34av6x/images/stencil/1280x1280/products/12889/77298/grrly-grrls-crimson-elegance-turtleneck-gown__05612.1734861376.jpg?c=1')",
  ];

  static const List<String> _insercoesSapato = [
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Scarpin Preto Verniz Salto Alto Fino', 'Salto', 'Preto', 'Constance', 'https://constance.vtexassets.com/arquivos/ids/2373326-1200-auto?v=638757392018200000&width=1200&height=auto&aspect=true')",
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Salto Geométrico', 'Salto', 'Preto', 'Vizzano', 'https://static.dafiti.com.br/p/vizzano-sand%C3%A1lia-vizzano-salto-geom%C3%A9trico-preta-7306-54537441-1-zoom.jpg?ims=filters:quality(70)')",
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Sandália Meia Pata', 'Salto', 'Preto', 'Mordapé', 'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-preto-m40-7536-38203041-1-zoom.jpg?ims=filters:quality(70)')",
    "INSERT INTO sapato (modelo, tipo, cor, marca, url_foto) VALUES ('Sandália Meia Pata', 'Salto', 'Branco', 'Mordapé', 'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-branco-m40-7535-97792041-1-zoom.jpg?ims=filters:quality(70)')",
  ];

  static const List<String> _insercoesAcessorio = [
    "INSERT INTO acessorio (modelo, tipo, cor, marca, url_foto) VALUES ('Pulseira Life', 'Pulseira', 'Prata', 'Vivara', 'https://lojavivara.vtexassets.com/arquivos/ids/2471327-1600-1600/PL00015208-1.jpg.jpg?v=638804193927070000')",
    "INSERT INTO acessorio (modelo, tipo, cor, marca, url_foto) VALUES ('Pulseira Life Infinito', 'Pulseira', 'Prata', 'Vivara', 'https://lojavivara.vtexassets.com/arquivos/ids/930609-1600-1600/Pulseira-Life-Infinito-em-Prata-925-86754_1_set.jpg?v=638745493413630000')",
  ];

  static const List<String> _insercoesLook = [
    "INSERT INTO look (nome) VALUES ('Look de Festa')",
    "INSERT INTO look (nome) VALUES ('Look Casual')",
  ];

  static const List<String> _insercoesLookItem = [
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 1, 'roupa')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 1, 'sapato')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (1, 2, 'acessorio')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 3, 'roupa')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 2, 'sapato')",
    "INSERT INTO look_item (id_look, id_item, tipo_item) VALUES (2, 1, 'acessorio')",
  ];

  static const List<String> _insercoesEvento = [
    "INSERT INTO evento (nome, data, id_look) VALUES ('Aniversário', '2025-07-15', 2)",
    "INSERT INTO evento (nome, data, id_look) VALUES ('Shopping', '2025-08-01', 1)",
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
