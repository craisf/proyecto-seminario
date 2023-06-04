document.addEventListener("DOMContentLoaded", ()=>{
    const cardMenu = document.querySelector("#container-card");    
    const MDOrdennuevo = new bootstrap.Modal(document.querySelector("#modal-orden"));
    const MDDetalle = new bootstrap.Modal(document.querySelector("#modal-detalle-orden"));
    const MDAgproducto = new bootstrap.Modal(document.querySelector("#modal-producto-agregar"));

    let idmesa=0;


    function renderData(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listar");
        fetch("../controllers/Mesa.controller.php",{
            method: 'POST',
            body: parametros            
        })
            .then((res) =>(res).json())
            .then((datos)=>{
                cardMenu.innerHTML = "";
                datos.forEach((element)=>{
                    const bgStatus = (element.estado ==='D') ? 'bg-success-subtle': (element.estado === 'O') ? 'bg-success-table' : 'bg-warning-subtle';
                    const status = (element.estado === 'D') ? 'Disponible' : (element.estado === 'O') ? 'Ocupado': 'Disponible';
                    const card = `
                        <div class="cold mt-3">
                            <div class="card ${bgStatus}" data-idmesa='${element.idmesa}' data-status=${element.estado}>
                                <div class="card-body">
                                    <div class="row d-flex justify-content-between">
                                        <div class="col">
                                            <h4 class="card-title">${element.numesa}</h4>
                                        </div>
                                        <div class="col">
                                            <p class="text-end fw-medium">${status}</p>
                                        </div>
                                    </div>
                                    <p class="card-text">Capacidad: ${element.capacidad} Personas</p>
                                    <hr>
                                    <div class='d-flex justify-content'>
                                        <button class="btn btn-outline-secondary ms-1 detalle">
                                            <i class="fa-solid fa-bars-staggered"></i>
                                        </button>
                                        <button class="btn btn-outline-secondary ms-1 agregar-producto">
                                            <i class="fa-solid fa-circle-plus"></i>
                                        </button>
                                        <button class="btn btn-outline-secondary ms-1 pagar">
                                            <i class="fa-solid fa-sack-dollar"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>   
                        </div>
                        `;
                    cardMenu.innerHTML +=card;
                })
            })

    }

    cardMenu.addEventListener("click", (e)=>{
        const card = e.target.closest(".card");
        if(card && !e.target.closest('.btn')){
            if(card.dataset.status === "D"){
                document.querySelector("#form-orden-nueva").reset();
                document.querySelector("#md-tabla-datalle-orden tbody").innerHTML ="";
                document.querySelector("#md-mesa").dataset.idmesa = card.dataset.idmesa;
                document.querySelector("#md-mesa").value = card.querySelector("h4").textContent;
                MDOrdennuevo.toggle();
            }
        }
    })

    function ListarEmpleados(){
        const parametros = new URLSearchParams();
        parametros.append("operacion", "listar");
        fetch("../controllers/Empleados.controller.php",{
            method: 'POST',
            body: parametros
        })
            .then(res =>res.json())
            .then(datos=>{
                datos.forEach((element) =>{
                    const option = document.createElement("option");
                    option.textContent = element.nombre + " " + element.apellido;
                    option.value = element.idempleado;
                    document.getElementById('md-empleados').appendChild(option);
                })
            })
    }

    function listarProductos(){
        const parametros = new URLSearchParams();
        parametros.append("operacion", "listarProductos");
        fetch("../controllers/Producto.controller.php",{
            method: 'POST',
            body: parametros
        })            
            .then((res) => res.json())
            .then((datos) =>{                
                datos.forEach((element)=>{
                    const opmd = document.createElement("option");
                    opmd.textContent = element.nombreproducto;
                    opmd.value = element.idproducto;
                    opmd.setAttribute("datos-precio", element.precio);
                    document.querySelector("#md-producto").appendChild(opmd);

                    const opag = document.createElement("option");
                    opag.textContent = element.nombreproducto;
                    opag.value = element.idproducto;
                    opag.setAttribute("datos-precio",element.precio);
                    document.querySelector("#ag-producto").appendChild(opag);
                    
                });                
            });
    }

    function detalle(idmesa){
        const parametros = new URLSearchParams();
        parametros.append("operacion", "VentaxMesa");
        parametros.append("idmesa", idmesa);
        fetch("../controllers/Orden.controller.php",{
            method: 'POST',
            body: parametros
        })
            .then(response => response.json())
            .then(datos=>{
                const idorden = datos[0];
                const BuscarOrden = new URLSearchParams();
                BuscarOrden.append("operacion", "buscarOrden");
                BuscarOrden.append("idorden", idorden);                
                const detalleOrden = new URLSearchParams();
                detalleOrden.append("operacion", "DetalleOrden");
                detalleOrden.append("idorden", idorden);
                detalleOrden.append("idmesa", idmesa);

                const p1 = fetch("../controllers/Orden.controller.php",{
                    method: 'POST',
                    body: BuscarOrden
                });
                const p2 = fetch("../controllers/Orden.controller.php",{
                    method: 'POST',
                    body:   detalleOrden                    
                });

                Promise.all([p1,p2])
                    .then(response=>{
                        const res =response[0].json();
                        const res1 = response[1].json();
                        return Promise.all([res,res1]);
                    })
                    .then(datos=>{
                        const busca =  datos[0];
                        const detalle = datos[1];

                        document.querySelector("#md-dt-fecha").value = busca.fechahoraorden;
                        document.querySelector("#md-dt-mesa").value = busca.numesa;
                        document.querySelector("#md-dt-empleado").value= busca.empleado;
                        document.querySelector("#md-dt-tabla-datalle-orden tbody").innerHTML="";
                        let total =0.0;
                        let fila = 1;

                        detalle.forEach(element =>{
                            const f =`
                            <tr>
                                <td>${fila}</td>
                                <td>${element.nombreproducto}</td>
                                <td>${element.cantidad}</td>
                                <td>${element.precio}</td>
                                <td>${element.Importe}</td>
                            </tr>
                            `;
                            fila++;
                            document.querySelector("#md-dt-tabla-datalle-orden tbody").innerHTML+= f;
                            total += parseFloat(element.Importe);
                        })                                                
                        document.querySelector("#md-dt-total").value = total.toFixed(2);

                        MDDetalle.toggle();
                    })
                    .catch(error =>{
                        console.log(error);
                        alert("Problemas");
                    })
            })
    }

    function aggdetalletabla(){
        if(
            !document.querySelector("#md-producto").value ||
            !document.querySelector("#md-cantidad").value ||
            !document.querySelector("#md-precio").value ||
            !document.querySelector("#md-total").value 
        ){

        }else{
            const MDproducto = document.querySelector("#md-producto");
            const MDcantidad = document.querySelector("#md-cantidad");
            const MDprecio = document.querySelector("#md-precio");
            const MDtotal = document.querySelector("#md-total");

            let cuerpotabla = document.querySelectorAll("#md-tabla-datalle-orden tbody");

            let filas = Array.from(cuerpotabla[0].children);

            let filaexiste = filas.find(row=>{
                let productoNombre = row.cells[1].innerHTML;
                return(
                    productoNombre === MDproducto.options[MDproducto.selectedIndex].text
                );
            });
            
            if(filaexiste){
                let NombreProducto = filaexiste.cells[1].textContent;
                let OpcionProducto = Array.from(MDproducto.option).find(
                    (option) => option.text === NombreProducto
                );

                let cantidad = OpcionProducto(filaexiste.cells[2].innerHTML) + parseInt(MDcantidad.value);                
            }else{
                let nuevafila = `
                <tr data-idproducto='${MDproducto.value}'>
                    <td>${filas.length+1}</td>
                    <td>${MDproducto.option[MDproducto.selectedIndex].text}</td>
                    <td>${MDcantidad.value}</td>
                    <td>${MDprecio.value}</td>
                    <td>${MDtotal.value}</td>
                    <td>
                        <a></a>    
                        <a></a>
                        <a></a>
                    </td>
                </tr>
                `;
                document.querySelector("#md-tabla-datalle-orden tbody").innerHTML += nuevafila;
            }
            MDAgproducto.selectedIndex=0;
            MDcantidad.value="1";
            MDprecio.value="";
            MDtotal.value="";

            calculaImporte();
        }
    }

    function calculaImporte(){
        let CuerpoTabla = document.querySelectorAll("#md-tabla-datalle-orden tbody");
        let filatablas = Array.from(CuerpoTabla[0].children);
        let total = 0.0;
        filatablas.forEach((element)=>{
            total+= parseFloat(element.cells[4].textContent);
        });
        document.querySelector("#md-total").value = total.toFixed(2);
    }

    function RegistrarOrden(){
        if(
            !document.querySelector("#md-mesa").value ||
            !document.querySelector("#md-empleados").value ||
            !document.querySelector("#md-tabla-detalle-orden tbody").childElementCount
        ){
            alert("Complete los campos");
        }else{
            if(confirm("Esta seguro de registrar")){
                const parametros = new URLSearchParams();
                parametros.append("operacion", "registrarOrden");
                parametros.append("idmesa", parseInt(document.querySelector("#md-mesa").dataset.idmesa));
                parametros.append("idempleado", parseInt(document.querySelector("#md-empleados").dataset.value));
                fetch("../controllers/Orden.controller.php", {
                    method: 'POST',
                    body: parametros
                })
                    .then(res=>res.json())
                    .then(datos=>{
                        if(datos.success){
                            let tablacuerpo = querySelectorAll("#md-tabla-detalle-orden tbody");
                            let filatabla = Array.from(tablacuerpo[0].children);

                            filatabla.forEach(element=>{
                                const parametro = new URLSearchParams();
                                parametro.append("operacion", "RegistrarDetalleOrden");
                                parametro.append("idproducto",element.dataset.idproducto);
                                parametro.append("cantidad", element.cells[2].textContent);
                                fetch("../controllers/Orden.controller.php",{
                                    method: 'POST',
                                    body: parametro
                                })
                            });

                            const pm = new URLSearchParams();
                            pm.append("operacion", "cambiarestado");
                            pm.append("idmesa",document.querySelector("md-mesa").dataset.idmesa);
                            pm.append("estado", "O");
                            fetch("../controllers/Mesa.controller.php",{
                                method: 'POST',
                                body: pm
                            })
                            MDOrdennuevo.toggle();
                            document.querySelector("#form-orden-nueva").reset();
                            document.querySelector("#md-tabla-datalle-orden").innerHTML="";
                            renderData();
                        }else{
                            alert(datos.message);
                        }
                    })

            }

        }

    }

    listarProductos();
    ListarEmpleados();
    detalle();
    renderData();
})