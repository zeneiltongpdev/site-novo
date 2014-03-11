USE 'mst2';

insert ignore into users set
name = 'batista',
pass = MD5('batista'),
mail = 'batista@gmail.com',
mode = 0,
sort = 0,
threshold = 0,
theme = '',
signature = '',
created = 1249922533,
access = 0,
login = 0,
status = 1,
timezone = null,
language = '',
picture = '',
init = 'batista@gmail.com',
data = 'a:1:{s:7:"contact";i:1;}',
signature_format = 0;

insert ignore into users_roles set uid = LAST_INSERT_ID(), rid = 3;
