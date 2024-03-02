# onfly

Projeto de aplicativo baseado no desafio da OnFly

## Descrição do desafio

Tarefas:
1. Interface de Usuário (UI) e Navegação:
Desenvolva as telas principais da aplicação com base nos seguintes requisitos: Tela de login: Permita que os usuários façam login usando e-mail e senha.
Tela principal: Após o login, exiba uma lista de despesas de viagem, com opções para adicionar, visualizar e editar despesas.
Crie uma tela voltada para os dados do cartão corporativo do usuário onde terão infos como: Saldo, bandeira e extrato.
Crie uma tela que mostre o status das viagens agendadas do usuário (afinal, o app também tem foco em fazer a gestão de viagem do usuário) - Cartão de embarque, horário de voo, cia aérea e aeroporto.
2. Funcionalidade Offline First:
Implemente a funcionalidade "offline first" para a lista de despesas de viagem. As despesas devem ser armazenadas localmente no dispositivo e sincronizadas com o servidor quando a conexão estiver disponível. Certifique-se de lidar com cenários de conflitos de sincronização.
3. Captura de Despesas:
Adicione a capacidade de capturar novas despesas de viagem, incluindo campos como data, valor, categoria e descrição. Garanta que os dados sejam armazenados localmente e sincronizados conforme especificado na tarefa 2.
4. Relatórios de Despesas:
Desenvolva uma funcionalidade para gerar relatórios de despesas com base nos dados registrados. Os usuários devem poder visualizar relatórios detalhados com gráficos e filtros para diferentes períodos de tempo.
5. Testes Unitários e de Integração:
Escreva testes unitários e de integração para garantir a qualidade do código e a estabilidade da aplicação. Certifique-se de cobrir diferentes aspectos, incluindo lógica de negócios, interações com o banco de dados local e comunicação com o servidor.
6. Documentação e Justificativa:
Forneça documentação sobre as escolhas de design, arquitetura.

## Tecnologia e bibliotecas

- Aplicativo desenvolvido com o framework Flutter
- Utilização da Clean Arch
    -- Layers
        - Data
            Camada de obtenção e armazenamento de dados
        - Domain
            Camada com as regras de negócio
        - Presentation
            Camada de view e gerência de estado das páginas
- Gerência de estado utilizando Cubit
- Utilização do Hive para banco de dados local
    -- Banco de dados local separados por feature para melhor gerência dos dados
- Firebase como 'backend' da aplicação
    -- Banco de dados (Realtime Database)
    -- Login e registro (Firebase Auth)

## Getting Started

- Login padrão:
    login: teste@teste.com
    senha: password123
