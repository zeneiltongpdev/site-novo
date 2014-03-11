echo "Ola vamos comecar" 

if [ ! -e "mst.sql.gz" ];  then
  echo "O arquivo do banco de dados nao existe baixando agora."
  wget -cv -O mst.sql.gz https://www.dropbox.com/s/rxvsfcf46xp11iu/mst.sql.gz
fi

echo "Desconpactando o arquivo e atualizando a base de dados"
gunzip -vc mst.sql.gz > mst.sql
mysql -u root -p -h localhost < mst.sql

echo "Inserindo o novo usuario"
mysql -u root -p -h localhost < create_user.sql

mkdir ~/Sites
path_drupal=${PWD%/*}"/drupal"

echo "criando o link simbolico para $path_drupal"
rm ~/Sites/mst
ln -sfn $path_drupal  ~/Sites/mst
