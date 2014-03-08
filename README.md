mst
===

Projeto da TW Brasil em conjunto com MST e Brasil de Fato

# setup

- clone the repo;
- download & extract the [db backup](https://www.dropbox.com/s/rxvsfcf46xp11iu/mst.sql.gz);
- restore the db;

```
$ mysql -u root -p -h localhost < mst.sql
```

- insert a new user in the db;

```
insert into users set
name = ‘batista’,
pass = MD5(‘batista’),
mail = ‘batista@gmail.com’,
mode = 0,
sort = 0,
threshold = 0,
theme = ‘',
signature = ‘',
created = 1249922533,
access = 0,
login = 0,
status = 1,
timezone = null,
language = ‘',
picture = ‘',
init = ‘batista@gmail.com’,
data = ‘a:1:{s:7:"contact";i:1;}',
signature_format = 0;
```

- make him an admin;

```
insert into users_roles set uid = <id do batista>, rid = 3;
```

- copy everything inside the drupal directory to the apache directory (in a mac, it is at /Library/WebServer/Documents);

- in your httpd.conf uncomment the following line:

```
LoadModule php5_module libexec/apache2/libphp5.so
```

- update sites/mst/settings.php with this:

```
$db_url = ‘mysql://root@localhost/mst2';
$base_url = 'http://localhost';
```

- restart apache;

```
$ sudo apachectl restart
```

- point your browser to [http://localhost/?q=admin/settings/clean-urls](http://localhost/?q=admin/settings/clean-urls)
- login with the user you created;
- turn-off clean urls;
- have some coffee and enjoy your local mst instance ;)

### mst on jekyll

**migration**

make sure you have these gems installed

```gem install jekyll-import```


run and wait for the migration to finish

```ruby jekyll_mst.rb ```


*Caution: As jekyll is static, the migration will create several files on the _posts and _pages directories*

**run**
```jekyll serve``` and open http://localhost:4000/mst/