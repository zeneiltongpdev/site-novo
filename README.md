MST site-novo
===
Projeto da TW Brasil em conjunto com MST e Brasil de Fato.

## Requirements
* mysql >= 5.0
* ruby >= 2.0
* node >= 0.10

## Setup

Clone the repository:

```
git clone https://github.com/movimento-sem-terra/site-novo.git && cd site-novo
```

Assuming your Mysql installation has an user called "root" with no password:

```
./setup
```

Otherwise, provide the password for "root":

```
./setup mysqlpassword
```

## Run

Start Grunt:

```
./node_modules/.bin/grunt watch
```

Start Jekyll:

```
jekyll serve -w
```

Point you browser to [http://localhost:4000/site-novo/agronegocio/]()

Done :)
