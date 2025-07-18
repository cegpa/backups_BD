# Backup Automático do Banco de Dados CEGPA

Este repositório é utilizado exclusivamente para armazenar os backups automáticos do banco de dados do sistema CEGPA.

## Processo Automatizado

- Um script `.bat` é executado diariamente para:
  1. Gerar um arquivo de backup do banco de dados MySQL (.sql) com data e hora no nome.
  2. Manter apenas os 7 arquivos de backup mais recentes na pasta, apagando os mais antigos automaticamente.
  3. Realizar o commit e push automático desses arquivos para este repositório no GitHub.

## Observações

- O repositório serve apenas para controle e histórico dos backups automáticos do banco de dados.
- Não armazene outros arquivos que não sejam relacionados ao backup do banco nesta pasta.
- O processo de backup e envio para o GitHub é totalmente automatizado e não requer intervenção manual.