-- conteudo
SELECT nid, title FROM node;

-- conteudo com tipo
SELECT n.title, t.name as tipo
FROM node as n
INNER JOIN node_type as t ON n.type = t.type;

-- total de conteudo por tipo
SELECT t.name as tipo, count(n.type), n.type
FROM node as n
INNER JOIN node_type as t ON n.type = t.type
GROUP BY n.type;

-- tipos de conteudo
SELECT name as tipo FROM node_type;

-- taxonomia sendo aplicada para cada tipo
SELECT t.name as tipo, GROUP_CONCAT( v.name SEPARATOR ' | ' ) as 'recebe taxonomia'
FROM node_type t
LEFT OUTER JOIN vocabulary_node_types as vt ON t.type = vt.type
LEFT OUTER JOIN vocabulary as v ON v.vid = vt.vid
GROUP BY t.name;

-- taxonomia/vocabulario
SELECT vid, name as vocabulario,
CONCAT(tags, multiple, required) AS tmr
FROM vocabulary;

-- taxonomia junto com lista de tipos
SELECT v.vid, v.name as vocabulario,
CONCAT(tags, multiple, required) AS tmr,
GROUP_CONCAT( t.name SEPARATOR '|' ) as 'aplica para tipo'
FROM vocabulary as v
LEFT OUTER JOIN vocabulary_node_types as vt ON v.vid = vt.vid
LEFT OUTER JOIN node_type as t ON t.type = vt.type
GROUP BY v.vid;


-- TERMOS POR VOCABULARIO
	--- TAGS de AutoComplete por Vocabulário
	SELECT v.name as tipo, d.name
	FROM term_data AS d
	INNER JOIN vocabulary AS v
	ON d.vid = v.vid
	WHERE v.vid IN ( SELECT vid FROM vocabulary WHERE tags=1 );
	--- TAGS de Multipla Escolha por Vocabulário
	SELECT d.name, v.name as tipo
	FROM term_data AS d
	INNER JOIN vocabulary AS v
	ON d.vid = v.vid
	WHERE v.vid IN ( SELECT vid FROM vocabulary WHERE multiple=1 );

-- Termos associados em cada conteudo
SELECT n.nid,
GROUP_CONCAT( d.name SEPARATOR '|' ) as 'tags'
FROM node as n
LEFT OUTER JOIN term_node as tn ON tn.nid = n.nid
LEFT OUTER JOIN term_data as d on tn.tid = d.tid
GROUP BY n.nid;

-- Imagens de um node
SELECT u.fid, vid, list, weight, filepath
FROM upload as u
LEFT OUTER JOIN files AS f
ON f.fid = u.fid
WHERE u.nid=15701
AND f.status = 1
AND u.list = 1
AND filepath LIKE '%JPG%';















-- QUERY COMPLETA DE PUBLICAÇÕES
SELECT n.nid,
n.title,
nr.body,
n.created,
n.status,
GROUP_CONCAT( CONCAT(v.name,':', tags.name) SEPARATOR '|' ) as 'Tags'
FROM node_revisions AS nr, node AS n
LEFT OUTER JOIN term_node as tn ON tn.nid = n.nid
LEFT OUTER JOIN term_data as tags on tn.tid = tags.tid
LEFT OUTER JOIN vocabulary as v on v.vid = tags.vid
WHERE n.type='story'
AND n.vid = nr.vid
GROUP BY n.nid
LIMIT 10;

SELECT n.nid, n.title,
'' as body,
GROUP_CONCAT( CONCAT(v.name,':', tags.name) SEPARATOR '|' ) as 'tags',
GROUP_CONCAT( CONCAT(f.filepath) SEPARATOR '|' ) as 'fotos'
FROM node_revisions AS nr, node AS n
LEFT OUTER JOIN term_node as tn ON tn.nid = n.nid
LEFT OUTER JOIN term_data as tags on tn.tid = tags.tid
LEFT OUTER JOIN upload as u on u.nid = n.nid
LEFT OUTER JOIN files AS f on f.fid = u.fid
LEFT OUTER JOIN vocabulary as v on v.vid = tags.vid
WHERE n.type='story' and NOT v.name IS NULL
AND n.vid = nr.vid
AND f.status = 1
AND u.list = 1
AND f.filepath LIKE '%JPG%'
GROUP BY n.nid;
