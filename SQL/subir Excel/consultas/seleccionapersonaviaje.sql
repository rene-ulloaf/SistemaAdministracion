Select
	 rut
	,dv
	,nombres As nombre
	,apePaterno As papellido
	,apeMaterno As sapellido
	,'' As nacionalidad
	,'' As region
	,'' As ciudad
	,'' As comuna
	,direccion
	,numero
	,email As mail
	,'' As fonoCasa
	,'' As fonoCel
	,'' As fonoTrabajo
	,fonoContactoOrigen As otroFono
	,idSexo As sexo
	,0 As sist
From Viajes.viaje.persona
where email <> ''