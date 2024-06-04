<%-- 
    Document   : RegistrarVenta
    Created on : 29/05/2024, 12:44:07 p. m.
    Author     : dylan
--%>

<%@page import="Modelo.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    HttpSession sesion = request.getSession();
    Empleado e = (Empleado) sesion.getAttribute("user");

    if (e != null){
%>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">        
        <link rel="stylesheet" type="text/css" href="Estilos/estiloFunNav.css"/>
        <link rel="stylesheet" type="text/css" href="Estilos/estiloGenerarRecibo.css"/>
        <title>JSP Page</title>
    </head>

    <body>
        <div class="form-group text-center pt-4">
            <h3>Registrar Venta</h3>
        </div>

        <div class="d-flex pr-1 pl-1 pb-5 pt-1">
            <div class="form col-sm-5">
                <div class="card">
                    <form action="Controlador?menu=NuevaVenta" method="post">
                        <div class="card-body">
                            <div class="form-group">
                                <label>Datos del Cliente</label>
                            </div>

                            <div class="form-group d-flex">
                                <div class="col-sm-6 d-flex">
                                    <input class="form-control" type="text" name="codigoCliente" value="${c.getDni()}" placeholder="Dni">
                                    <input class="btn btn-info" type="submit" name="accion" value="Buscar Cliente">
                                </div>

                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="nombresCliente" value="${c.getNombre()}" placeholder="Datos Cliente">
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Datos Producto</label>
                            </div>

                            <div class="form-group d-flex">
                                <div class="col-sm-6 d-flex">
                                    <input class="form-control" type="text" name="codigoProducto" value="${p.getId()}" placeholder="ID">
                                    <input class="btn btn-info" type="submit" name="accion" value="Buscar Producto">
                                </div>

                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="nombresProducto" value="${p.getNombre()}" placeholder="Datos Producto">
                                </div>
                            </div>

                            <div class="form-group d-flex">
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="precio" value="${p.getPrecio()}" placeholder="S/.0.00">
                                </div>

                                <div class="col-sm-3">
                                    <input class="form-control" type="number" name="cant" value="1" placeholder="Cant.">
                                </div>

                                <div class="col-sm-3">
                                    <input class="form-control" type="text" name="stock" value="${p.getStock()}" placeholder="Stock">
                                </div>
                            </div>

                            <div class="form-group">
                                <input class="btn btn-info rounded-pill" type="submit" name="accion" value="Agregar">
                                <a class="btn btn-secondary rounded-pill" href="Controlador?menu=NuevaVenta&accion=Limpiar">Limpiar/Actualizar</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-sm-7">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex col-sm-5 ml-auto">
                            <label>Número de Serie</label>
                            <input class="form-control rounded-pill" type="text" name="noSerie" value="${noSerie}">
                        </div>

                        <br>
                        <table class="table table-hover table-dark">
                            <thead>
                                <tr>
                                    <th>Nro.</th>
                                    <th>Codigo</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                    <th>SubTotal</th>
                                    <th class="colAccion">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="v" items="${listaV}">
                                    <tr>
                                        <td>${v.getItem()}</td>
                                        <td>${v.getIdProducto()}</td>
                                        <td>${v.getDescripcionP()}</td>
                                        <td>${v.getPrecio()}</td>
                                        <td>${v.getCant()}</td>
                                        <td>${v.getSubTotal()}</td>
                                        <td class="d-flex">
                                            <a href="#" onclick="editar(${v.getItem()},${v.getCant()})" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#exampleModal">Editar</a>
                                            <form action="Controlador?menu=NuevaVenta" method="POST" >
                                                <input type="number" name="id" value="${v.getItem()}" style="display: none;"></input> 
                                                <input class="btn btn-danger" value="Eliminar" name="accion" type="submit" style="margin-left: 10px"></input>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>        
                      <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 style="color: black" class="modal-title" id="exampleModalLabel">Editar</h5>
                                    </div>
                                    <form action="Controlador?menu=NuevaVenta" method="POST">
                                        <div class="modal-body" >
                                            <input type="number" id="prodItem" name="id" value="1" style="display: none;"></input> 
                                            <label for="basic-url" style="color: black" class="form-label">Cantidad</label>
                                            <div class="input-group mb-3">
                                                <input type="number" class="form-control" name="cantidad" id="n-cantidad" aria-describedby="basic-addon3">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <input type="submit" class="btn btn-primary" name="accion" value="Guardar" id="gCambios"></input>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>                       
                    <div class="card-footer d-flex">
                        <div class="col-sm-6 d-flex justify-content-start">
                            <a class="btn btn-success rounded-pill mr-2" onclick="print()" href="Controlador?menu=NuevaVenta&accion=Generar+Venta">Generar Venta</a>
                            <form action="Controlador?menu=NuevaVenta" method="POST">
                                <input type="submit" name="accion" value="Cancelar" class="btn btn-danger rounded-pill">
                            </form>
                        </div>

                        <div class="col-sm-4 ml-auto d-flex">
                            <label class="pr-3 pt-2">Total</label>
                            <input class="form-control rounded-pill text-center" type="text" name="total" value="S/. ${total}0">
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <script>
            const inputNumber = document.getElementById("n-cantidad");
            const productItem = document.getElementById("prodItem");
            const guardCambios = document.getElementById("gCambios");
            guardCambios.disabled=true;
            const editar = (id,cant)=>{
                if(id !== 0){                    
                    guardCambios.disabled=false;
                }
                inputNumber.value=cant;
                productItem.value=id;
            }
        </script>              
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    </body>
</html>
<%
    }
    else{
        sesion.removeAttribute("user");
        sesion.invalidate();
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
%>