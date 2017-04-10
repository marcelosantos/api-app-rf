WITH lista_de_somatorios_cidadaos AS (
	SELECT 
		u.nome,
		u.email,
		u.cidade,
		u.idade,
		SUM(valor) AS soma_dos_bens
	FROM 
		bems AS b
	LEFT JOIN 
		usuarios AS u ON b.usuario_id = u.id
	GROUP BY 
		u.nome, 
		u.email,
		u.cidade,
		u.idade, 
		usuario_id
)

--SELECT * FROM lista_de_somatorios_cidadaos WHERE soma_dos_bens >= 100000

SELECT 
	u.nome,
	u.email,
	u.cidade,
	u.idade,
	SUM(valor) AS soma_dos_bens
FROM 
	bems AS b
LEFT JOIN 
	usuarios AS u ON b.usuario_id = u.id
GROUP BY 
	u.nome, 
	u.email,
	u.cidade,
	u.idade, 
	usuario_id
HAVING 
	SUM(valor) >= 100000
