Select
     substr(CM.RUT,1,instr(CM.RUT,'-')-1) rut
    ,substr(CM.RUT,length(CM.RUT),1) dv
    ,CM.NOMBRE nombre
    ,CM.APELLIDOPATERNO papellido
    ,CM.APELLIDOMATERNO sapellido
    ,CM.NACIONALIDAD nacionalidad
    ,CM.PAIS nacionalidad
    ,CM.REGION region
    ,CM.CIUDAD ciudad
    ,cm.comuna comuna
    ,CM.CALLE direccion
    ,CM.NUMEROCALLE numero
    ,CM.EMAIL mail
    ,CM.TELEFONOPARTICULAR fonoCasa
    ,CM.TELEFONOCELULAR fonoCel
    ,'' fonoTrabajo
    ,'' otroFono
    ,CM.SEXO sexo
    ,0 sis
From clientemok cm
Where CM.EMAIL is not null