# Fitness Friendzy Clone

Uma aplicação Flutter que replica as funcionalidades básicas do aplicativo "Fitness friendzy", desenvolvida com arquitetura limpa e padrões de desenvolvimento modernos.

## 📱 Funcionalidades Implementadas

### ✅ Funcionalidades Básicas
- **Visualização de Desafio Ativo**: Exibe informações completas do desafio atual
- **Barra de Progresso**: Indicador visual do andamento do desafio
- **Informações de Data**: Datas de início e conclusão do desafio
- **Código de Convite**: Sistema para convidar outros usuários
- **Lista de Equipas**: Visualização de todas as equipas participantes
- **Rankings**: Classificação das equipas por pontuação
- **Interface Responsiva**: Design adaptado para diferentes tamanhos de tela

### 🔄 Funcionalidades de Estado
- **Gerenciamento de Estado**: Implementado com Provider
- **Carregamento Assíncrono**: Indicadores de loading durante operações
- **Tratamento de Erros**: Mensagens de erro e retry automático
- **Refresh**: Pull-to-refresh para atualizar dados

## 🏗️ Arquitetura

O projeto segue os princípios de **Clean Architecture** com separação clara de responsabilidades:

```
lib/
├── core/                    # Utilitários e constantes compartilhadas
├── domain/                  # Entidades e regras de negócio
│   ├── entities/           # Modelos de domínio
│   ├── repositories/       # Interfaces de repositório
│   └── usecases/          # Casos de uso
├── data/                   # Camada de dados
│   ├── datasources/       # Fontes de dados (mock, API, local)
│   ├── models/           # Modelos de dados
│   └── repositories/     # Implementações de repositório
├── presentation/          # Interface do usuário
│   ├── pages/           # Telas da aplicação
│   ├── widgets/         # Componentes reutilizáveis
│   ├── providers/       # Gerenciamento de estado
│   └── theme/          # Tema e estilos
└── features/            # Funcionalidades específicas (futuro)
```

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.24.5**: Framework de desenvolvimento
- **Provider**: Gerenciamento de estado
- **Equatable**: Comparação de objetos
- **HTTP**: Comunicação com APIs (preparado para futuro)
- **SharedPreferences**: Armazenamento local (preparado para futuro)

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.24.5 ou superior
- Dart 3.5.4 ou superior

### Passos
1. Clone o repositório
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute a aplicação:
   ```bash
   flutter run
   ```

### Testes
Execute os testes com:
```bash
flutter test
```

Execute análise de código:
```bash
flutter analyze
```

## 📊 Dados Mock

A aplicação utiliza dados mock para demonstração, incluindo:
- 1 desafio ativo ("Fitness friendzy")
- 5 equipas com rankings e pontuações
- Dados de progresso e datas

## 🎨 Design

O design segue as diretrizes visuais do aplicativo original:
- **Cores**: Vermelho primário (#E53E3E), fundo claro (#F7FAFC)
- **Tipografia**: Hierarquia clara com diferentes pesos de fonte
- **Componentes**: Cards, listas, avatares e barras de progresso
- **Layout**: Design responsivo e intuitivo

## 🔮 Próximos Passos

### Funcionalidades Planejadas
- [ ] **Autenticação de Usuários**
  - Login/Registro
  - Gestão de perfis
  - Autenticação com redes sociais

- [ ] **Gestão de Desafios**
  - Criação de novos desafios
  - Edição de desafios existentes
  - Diferentes tipos de desafios

- [ ] **Sistema de Equipas**
  - Criação e gestão de equipas
  - Convites para equipas
  - Chat entre membros

- [ ] **Gamificação Avançada**
  - Sistema de pontos detalhado
  - Conquistas e badges
  - Histórico de atividades

- [ ] **Integração com APIs**
  - Backend real
  - Sincronização de dados
  - Notificações push

### Melhorias Técnicas
- [ ] Implementação de testes de integração
- [ ] Configuração de CI/CD
- [ ] Otimização de performance
- [ ] Implementação de cache local
- [ ] Suporte offline

## 📝 Estrutura de Commits

O projeto segue convenções de commit semântico:
- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Documentação
- `style:` Formatação
- `refactor:` Refatoração
- `test:` Testes

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é um clone educacional desenvolvido para fins de demonstração e aprendizado.

## 👥 Equipa de Desenvolvimento

Desenvolvido como parte de um projeto de estruturação de aplicação Flutter com foco em boas práticas e arquitetura limpa.



## 🆕 Nova Funcionalidade: Inserção de Pontos

### ✅ Funcionalidade Implementada
- **Botão Flutuante (+)**: Adicionado à página principal para acesso rápido
- **Página de Inserção de Pontos**: Interface completa para adicionar pontos às equipas
- **Seleção de Equipa**: Dropdown com todas as equipas disponíveis e suas informações
- **Validação de Entrada**: Campos validados com limites e formatação adequada
- **Atualização Automática de Rankings**: Rankings recalculados automaticamente após inserção
- **Feedback Visual**: Mensagens de sucesso/erro e indicadores de carregamento
- **Navegação Intuitiva**: Fluxo completo de ida e volta entre páginas

### 🔧 Componentes Adicionados

#### Camada de Domínio
- `UpdateTeamPoints`: Caso de uso para atualização de pontos
- `UpdateTeamPointsParams`: Parâmetros para o caso de uso

#### Camada de Dados
- `updateTeamPoints()`: Método no MockDataSource para simular atualização
- Lógica de reordenação automática de rankings por pontuação

#### Camada de Apresentação
- `AddPointsPage`: Página completa para inserção de pontos
- `FloatingActionButton`: Integrado na página principal
- Atualização do `TeamProvider` com método `updateTeamPoints()`

### 🎯 Fluxo de Uso
1. Utilizador clica no botão flutuante (+) na página principal
2. Navega para a página de inserção de pontos
3. Seleciona uma equipa do dropdown
4. Insere a quantidade de pontos (1-1000)
5. Confirma a operação
6. Sistema atualiza os pontos e reordena o ranking
7. Utilizador retorna à página principal com dados atualizados

### 🧪 Testes Implementados
- Teste de carregamento da página principal com botão flutuante
- Teste de atualização de pontos via TeamProvider
- Validação de reordenação automática de rankings
- Testes de interface e navegação

### 📱 Interface da Nova Funcionalidade
A página de inserção de pontos inclui:
- **Seletor de Equipa**: Dropdown com avatares, nomes e pontuação atual
- **Campo de Pontos**: Input numérico com validação
- **Botão de Submissão**: Com indicador de carregamento
- **Informações Contextuais**: Dicas sobre o funcionamento
- **Tratamento de Erros**: Mensagens claras para diferentes cenários

Esta funcionalidade completa o ciclo básico de gestão de pontuação, permitindo que os utilizadores interajam dinamicamente com o sistema de rankings das equipas.

