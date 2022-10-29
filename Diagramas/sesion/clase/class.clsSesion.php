<?php

error_reporting(E_ALL);

/**
 * Sesion - class.clsSesion.php
 *
 * $Id$
 *
 * This file is part of Sesion.
 *
 * Automatically generated on 07.05.2012, 11:31:14 with ArgoUML PHP module 
 * (last revised $Date: 2010-01-12 20:14:42 +0100 (Tue, 12 Jan 2010) $)
 *
 * @author René Ulloa
 * @version 1.0.0
 */

if (0 > version_compare(PHP_VERSION, '5')) {
    die('This file was generated for PHP 5');
}

/* user defined includes */
// section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2B-includes begin
// section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2B-includes end

/* user defined constants */
// section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2B-constants begin
// section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2B-constants end

/**
 * Short description of class clsSesion
 *
 * @access public
 * @author René Ulloa
 * @version 1.0.0
 */
class clsSesion
{
    // --- ASSOCIATIONS ---


    // --- ATTRIBUTES ---

    /**
     * Short description of attribute conexion
     *
     * @access private
     * @var String
     */
    private $conexion = null;

    /**
     * Short description of attribute idSistema
     *
     * @access private
     * @var int
     */
    private $idSistema = 0;

    // --- OPERATIONS ---

    /**
     * Short description of method __construct
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  String conexion
     * @param  Integer sistema
     */
    public function __construct( String $conexion,  Integer $sistema)
    {
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2C begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C2C end
    }

    /**
     * Short description of method GetIdUsuario
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @return int
     */
    public function GetIdUsuario()
    {
        $returnValue = (int) 0;

        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C36 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C36 end

        return (int) $returnValue;
    }

    /**
     * Short description of method UsuarioValido
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  String nomUsuario
     * @param  String pass
     * @return bool
     */
    public function UsuarioValido( String $nomUsuario,  String $pass)
    {
        $returnValue = (bool) false;

        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C44 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C44 end

        return (bool) $returnValue;
    }

    /**
     * Short description of method ObtDatosUsuario
     *
     * @access private
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  String nomUsuario
     */
    private function ObtDatosUsuario( String $nomUsuario)
    {
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C48 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C48 end
    }

    /**
     * Short description of method Bloqueado
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @return bool
     */
    public function Bloqueado()
    {
        $returnValue = (bool) false;

        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C4C begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C4C end

        return (bool) $returnValue;
    }

    /**
     * Short description of method CantPerfiles
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @return int
     */
    public function CantPerfiles()
    {
        $returnValue = (int) 0;

        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C4E begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C4E end

        return (int) $returnValue;
    }

    /**
     * Short description of method InicioSesion
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  String index
     * @param  String redirect
     */
    public function InicioSesion( String $index,  String $redirect)
    {
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C50 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C50 end
    }

    /**
     * Short description of method InicioSesion
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  Integer idSistema
     * @param  Integer idUsuario
     * @param  Integer idPerfil
     */
    public function InicioSesion( Integer $idSistema,  Integer $idUsuario,  Integer $idPerfil)
    {
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C54 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C54 end
    }

    /**
     * Short description of method SesionPerfil
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     */
    public function SesionPerfil()
    {
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C59 begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C59 end
    }

    /**
     * Short description of method ObtenerPerfiles
     *
     * @access public
     * @author René Ulloa F., <rulloaf@skberge.cl>
     * @param  Integer idSistema
     * @param  Integer idUsuario
     * @return String
     */
    public function ObtenerPerfiles( Integer $idSistema,  Integer $idUsuario)
    {
        $returnValue = null;

        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C5B begin
        // section -84-16-4-14--d1809e7:1372792a1cc:-8000:0000000000000C5B end

        return $returnValue;
    }

} /* end of class clsSesion */

?>