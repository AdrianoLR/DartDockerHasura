# Hasura + Dart + Docker
Conectando ao Hasura usando Dart e Docker:

Instale o Docker na sua maquina, verifique se obtiver erros com WSL 2, precisará seguir alguns passos para ativa-lo no Windows 10, após configura-lo, o arquivo docker-compose que esta na Master será o responsável pela criação do Hasura.

**Comandos:**
  - `docker-compose up -d` : **para subir o docker com as configurações do Hasura.**
  - `docker-compose down` : **para parar o docker e subir novamente caso haja alteração no arquivo.**

No Hasura vá em configurações e importe o metadata em formato .json que esta na solução.

Utilize o Action `loginAction()` que foi criado para bater na back-end no Dart:

```
query MyQuery {
  loginAction(email: "", password: "", id_company: 1) {
    expireIn
    accessToken
    refreshToken
  }
}
```

Pegue os valores cadastrados na tabela de usuarios para inseri-los corretamente no método.


# CRÉDITOS  
Fluterrando e ao Jacob Moura   

Video aula desse projeto  
https://www.youtube.com/watch?v=ttRdrySzvRY
