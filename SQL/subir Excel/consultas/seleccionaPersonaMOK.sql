Select
	 UsuPerRut As rut
	,'' As dv
	,UsuNombre As nombre
	,'' As papellido
	,'' As sapellido
	,'' As nacionalidad
	,'' As region
	,'' As ciudad
	,'' As comuna
	,'' As direccion
	,'' As numero
	,Usumail As mail
	,'' As fonoCasa
	,'' As fonoCel
	,'' As fonoTrabajo
	,'' As otroFono
	,'' As sexo
	,0 As sist
From sesion.IntUsuario
where Usumail <> ''