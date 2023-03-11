# Hasura + Dart + Docker
Connecting to Hasura using Dart and Docker:

Install Docker on your machine, check if you get errors with WSL 2, you will need to follow some steps to activate it in Windows 10, after configuring it, the docker-compose file that is in the Master will be responsible for creating Hasura.

**Commands:**
  - `docker-compose up -d` : **to upload docker with Hasura settings.**
  - `docker-compose down` : **to stop docker and go up again if there is a change in the file.**

In Hasura, go to settings and import the metadata in .json format that is in the solution.

Use the Action `loginAction()` that was created to hit the backend in Dart:

```
query MyQuery {
  loginAction(email: "", password: "", id_company: 1) {
    expireIn
    accessToken
    refreshToken
  }
}
```

Take the values registered in the users table to insert them correctly in the method.


# CRÉDITS  
Fluterrando and Jacob Moura
