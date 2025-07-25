# Meu Closet 👗✨  
O seu guarda-roupa digital, sempre à mão.

---

## 📖 Sobre o Projeto

**Meu Closet** é um aplicativo multiplataforma (**Web, Desktop e Mobile**) desenvolvido em **Flutter**, desenvolvido para fins acadêmicos da disciplina Desenvolvimento de Dispositíveis Móveis.  
Ele permite que você catalogue todas as suas peças de roupa, sapatos e acessórios, crie looks incríveis, planeje o que vestir para os seus eventos e até organize as suas malas de viagem.

---

## ✨ Funcionalidades Principais

O aplicativo conta com um sistema completo de **CRUDs** (Criar, Ler, Atualizar, Excluir) com associações complexas para uma gestão detalhada e realista do seu closet.

### 👤 Gestão de Perfil
- Sistema de cadastro e login de usuário.
- Visualização e edição do perfil com foto.

### 🧥 Closet Digital (Cadastros Simples)
- **👚 Roupas**: Adicione, edite, visualize e remova todas as suas peças de roupa.
- **👠 Sapatos**: Catalogue os seus sapatos com fotos e detalhes.
- **👜 Acessórios**: Organize as suas bolsas, joias, óculos e outros acessórios.

### 💃 Montagem de Looks (Associação N:N)
- Crie **Looks** combinando múltiplas peças do seu closet (roupas, sapatos e acessórios).
- Uma mesma peça pode ser usada em vários looks diferentes, graças a um relacionamento **muitos-para-muitos**.

### 🗓️ Planeador de Eventos (Associação 1:N)
- Registre os seus eventos futuros (festas, reuniões, etc.).
- Associe um Look específico a cada Evento para planejar o que vai vestir.

### 🧳 Organizador de Malas (Associação 1:N e N:N)
- Crie **Malas de Viagem** para diferentes ocasiões.
- Associe uma mala a um Evento específico (ex: "Férias na Praia").
- Adicione múltiplas peças do seu closet à mala, facilitando a organização.

---

## 🛠️ Arquitetura e Tecnologias

O projeto foi construído com foco em **boas práticas**, **componentização** e uma **arquitetura limpa** para facilitar a manutenção e escalabilidade.

- **Framework**: Flutter — para uma base de código única e uma experiência nativa em Web, Desktop (Windows, macOS, Linux) e Mobile (Android, iOS).
- **Linguagem**: Dart.
- **Base de Dados**: SQLite para persistência de dados local, utilizando o pacote `sqflite_common_ffi` para garantir a compatibilidade entre todas as plataformas.

### Arquitetura em Camadas:
- **Modelos (DTOs)**: Classes DTO (Data Transfer Object) para representar as entidades da aplicação (Roupa, Look, Evento, etc.).
- **Acesso a Dados (DAOs)**: Classes DAO (Data Access Object) que isolam toda a lógica de comunicação com a base de dados (queries SQL).
- **Interface (Widgets)**: A camada de apresentação, construída com widgets do Flutter, separada em `forms`, `lists`, `detalhes` e `componentes` reutilizáveis.

### Componentização:
Criação de componentes reutilizáveis como:
- `CampoTexto`
- `CampoFoto`
- `WidgetLinhaDetalhe` 
- `WidgetSeletorDeItens` 
para manter o código limpo e consistente.

### Check: [Tabela de Check](lib_desc/tabela_check.md)

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Ter o Flutter SDK instalado e configurado no seu ambiente.
- Um editor de código como o **VS Code**.

### Passos

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/meu_closet.git
   cd meu_closet
   ```

2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. (Apenas para Web) Configure os ficheiros do worker do SQLite:<br>
Este comando copia os ficheiros JavaScript necessários para a pasta web:

   ```bash
   flutter pub run sqflite_common_ffi_web:setup
   ```

4. Execute a aplicação:<br>
Escolha o dispositivo no qual deseja executar (ex: chrome, windows, android):

    ```bash
    flutter run -d chrome
    ```

## 👩‍💻 Autora
Laryssa Bino