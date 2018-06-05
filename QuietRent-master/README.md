<div align="center"><img src="https://res.cloudinary.com/quietrent/image/upload/v1493861981/logo-qr_t9gnsb.png"></div>





# QuietRent Webservices
That document describe the use of Webservices available with the QuietRent Solution.


## Authorization service

In order to query the webservice the user need to ask for an access token.
<a href="https://pro.quietrent.com/users/sign_up" target="_blank">Sign up here</a>


An email will be sent with the necessary information for the authentication of the webservice.

> _**REQUEST YOUR TOKEN**_

- **URL** : `https://pro.quietrent.com/api/v1/users/yourID`
- **request method** : `GET`
- **params** :

```
email=yourmail@gmail.com
password=yourpassword
```
- **type of data** : `JSON`

If you want to use this service with the `terminal`, you can send your request like this :

```
curl -i -X GET \
    -d "email=yourmail@gmail.com" \
    -d "password=yourpassword" \
    https://pro.quietrent.com/api/v1/users/yourID

```

If everything goes well, the response of the request should follow this schema :

```
{
  "id": yourID,
  "authentication_token": "yourToken"
}
```

`authentication_token` allows you to consume the webservice associated with the predictive algorithm

> Notice that the token is valid only for a given period of time (typically 1hr), after that you should request again the Authorization service to get a new token

---


## Predictive algorithm service

> _**CREATE EVALUATIONS**_

- **URL** : `https://pro.quietrent.com/api/v1/evaluations`
- **request method** : `POST`
- **header** :

```
Content­Type: application/json
X-User-Email: yourmail@gmail.com
X-User-Token: yourToken
```
- **type of data** : `JSON`

The body of the POST request should be in JSON format and should follow the following schema :

```
{
  "evaluation": [{
      "edp_loyer": 1000,
      "edp_situation_familiale": "Seul",
      "edp_revenus_mensuels": 2700,
      "edp_year_birth": "1980",
      "edp_contrat_travail": "CDI",
      "edp_city": "Paris"
    },
    {
      "edp_loyer": 1200,
      "edp_situation_familiale": "Couple sans enfant",
      "edp_revenus_mensuels": 2700,
      "edp_year_birth": "1980",
      "edp_contrat_travail": "CDI",
      "edp_city": "Dijon"
    }
  ]
}
```


> *BE CAREFUL TO CASE SENSITIVITY*

| `edp_situation_familiale` | `edp_contrat_travail` |
|:--------:|:--------:|
|  `Seul`   |  `CDI`   |
|  `Couple sans enfant` |  `CDD de plus de 8 mois`   |
|  `Famille monoparentale`  |  `Retraité`   |
|  `Couple avec enfant`   |  `Sans emploi`   |
|  &nbsp;   |  `Indépendant (professions libérales, auto-entrepreneur, etc...)`   |
|  &nbsp;   |  `Contrat précaire (étudiant, saisonnier, interim, mi-temps, etc...)`   |


If you want to use this service with the `terminal`, you can send your request like this :

```
curl -i -X POST \
     -H 'Content-Type: application/json' \
     -H 'X-User-Email: yourmail@gmail.com' \
     -H 'X-User-Token: yourToken' \
     -d '{ "evaluation": { "edp_loyer": 1000, "edp_situation_familiale": "Seul", "edp_revenus_mensuels": 2700, "edp_year_birth": "1980", "edp_contrat_travail": "CDI", "edp_city": "Paris" } }' \
     https://pro.quietrent.com/api/v1/evaluations
```

If everything goes well, the response of the request (in JSON format too) should follow this schema :

```
[
  {
    "id": :id,
    "edp_loyer": 1000,
    "edp_situation_familiale": "Seul",
    "edp_revenus_mensuels": 2700,
    "edp_year_birth": "1980",
    "edp_contrat_travail": "CDI",
    "edp_city": "Paris",
    "created_at": "2017-05-01T11:35:35.406Z",
    "updated_at": "2017-05-01T11:35:35.406Z",
    "user_id": yourID,
    "result_edp": "80"
  },
  {
    "id": :id,
    "edp_loyer": 1200,
    "edp_situation_familiale": "Seul",
    "edp_revenus_mensuels": 2700,
    "edp_year_birth": "1980",
    "edp_contrat_travail": "CDI",
    "edp_city": "Paris",
    "created_at": "2017-05-01T11:35:35.505Z",
    "updated_at": "2017-05-01T11:35:35.575Z",
    "user_id": yourID,
    "result_edp": "54"
  }
]
```
Where `result_edp` correspond to the rental reliability from 0 to 100.

---

> _**SHOW EVALUATION WITH ID**_

- **URL** : `https://pro.quietrent.com/api/v1/evaluations/:id`
- **request method** : `GET`
- **header** :

```
Content­Type: application/json
X-User-Email: yourmail@gmail.com
X-User-Token: yourToken
```
- **type of data** : `JSON`

If you want to use this service with the `terminal`, you can send your request like this :

```
curl -i -X GET \
      -H 'Content-Type: application/json' \
      -H 'X-User-Email: yourmail@gmail.com' \
      -H 'X-User-Token: yourToken' \
      https://pro.quietrent.com/v1/evaluations/:id
```
If everything goes well, the response of the request (in JSON format too) should follow this schema :

```
{
  "id": :id,
  "edp_loyer": 1200,
  "edp_situation_familiale": "Seul",
  "edp_revenus_mensuels": 2700,
  "edp_year_birth": "1980",
  "edp_contrat_travail": "CDI",
  "edp_city": "Paris",
  "result_edp": "54",
  "user_id": yourID,
  "created_at": "2017-05-01T11:35:35.505Z"
}
```

---

> _**SHOW ALL YOUR EVALUATIONS**_

- **URL** : `https://pro.quietrent.com/api/v1/evaluations`
- **request method** : `GET`
- **header** :

```
Content­Type: application/json
X-User-Email: yourmail@gmail.com
X-User-Token: yourToken
```
- **type of data** : `JSON`

If you want to use this service with the `terminal`, you can send your request like this :

```
curl -i -X GET \
      -H 'Content-Type: application/json' \
      -H 'X-User-Email: yourmail@gmail.com' \
      -H 'X-User-Token: yourToken' \
      https://pro.quietrent.com/api/v1/evaluations
```
If everything goes well, the response of the request (in JSON format too) should follow this schema :

```
[
  {
    "id": :id,
    "edp_loyer": 1000,
    "edp_situation_familiale": "Seul",
    "edp_revenus_mensuels": 2700,
    "edp_year_birth": "1980",
    "edp_contrat_travail": "CDI",
    "edp_city": "Paris",
    "result_edp": "81",
    "user_id": yourID,
    "created_at": "2017-04-24T16:39:46.841Z"
  },
  {
    "id": :id,
    "edp_loyer": 1000,
    "edp_situation_familiale": "Seul",
    "edp_revenus_mensuels": 2300,
    "edp_year_birth": "1980",
    "edp_contrat_travail": "CDI",
    "edp_city": "Paris",
    "result_edp": "20",
    "user_id": yourID,
    "created_at": "2017-04-24T16:40:08.725Z"
  }
]
```
