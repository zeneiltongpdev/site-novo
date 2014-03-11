mst
===

Projeto da TW Brasil em conjunto com MST e Brasil de Fato

# setup


- clone the repo;
- run ./config/init.sh

# Follow this steps: 

- Enable Web Sharing on the MAC by going to System Prefrences —> Sharing —> Check Enable Web Sharing
- Edit your username.conf file located in /private/etc/apache2/users and add the “FollowSymLinks” directive:

```
<Directory "/Users/<yourUserName>/Sites/">
    Options Indexes MultiViews FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
```

- Edit the /private/etc/apache2/httpd.conf file and make sure the line under “# Virtual hosts” is not commented out, like so:

```
Include /private/etc/apache2/extra/httpd-vhosts.conf
```

- And add this lines too:

```
Include /private/etc/apache2/users/*.conf
User <yourUseName>
```

- And verify this: 

```
<Directory "/Library/WebServer/Documents">
AllowOverride All
```

- Edit the /private/etc/apache2/extra/httpd-vhosts.conf file and add:

```
<VirtualHost *:80>  
    <Directory /Users/<yourUserName>/Sites/mst.com>
        Options +FollowSymlinks +SymLinksIfOwnerMatch
        AllowOverride All
    </Directory>
  DocumentRoot /Users/<yourUserName>/Sites/mst
  ServerName mst.local
</VirtualHost>
```

- Edit the /etc/hosts file and add this at the top:

```
127.0.0.1 mst.local
```

- in your httpd.conf uncomment the following line: 

```
LoadModule php5_module libexec/apache2/libphp5.so
```

- update sites/mst/settings.php with this:

``` 
$db_url = ‘mysql://root@localhost/mst2';
$base_url = 'http://mst.local/';
```

- restart apache;

```
$ sudo apachectl restart
```

- point your browser to [http://localhost/?q=admin/settings/clean-urls](http://localhost/?q=admin/settings/clean-urls)
- login with the user you created;
- turn-off clean urls;
- have some coffee and enjoy your local mst instance ;)
