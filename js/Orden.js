document.addEventListener("DOMContentLoaded", ()=>{
    const cardMenu = document.querySelector("#container-card");    

    const MDOrdennuevo = new bootstrap.Modal(
        document.querySelector("#modal-orden-nueva")
    );

    const MDDetalle = new bootstrap.Modal(
        document.querySelector("#modal-detalle-orden")
    );

    const MDAgproducto = new bootstrap.Modal(
        document.querySelector("#modal-producto-agregar")
    );
    const MDCambiar = new bootstrap.Modal(
        document.querySelector("#modal-cambiar-estado")
    );

    let idorden=0;


    function renderData(){
        const parametros = new URLSearchParams();
        parametros.append("operacion","listar");
        fetch("../controllers/Mesa.controller.php",{
            method: 'POST',
            body: parametros            
        })
            .then((res) => res.json())
            .then((datos)=>{
                cardMenu.innerHTML = "";
                datos.forEach((element)=>{
                    const bgStatus = (element.estado ==='D') ? 'bg-success-subtle': (element.estado === 'O') ? 'bg-danger-subtle' : 'bg-warning-subtle';
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
                                        <button class='btn btn-outline-secondary ms-1 detalle'>
                                            <i class="fa-solid fa-bars-staggered"></i>
                                        </button>
                                        <button class='btn btn-outline-secondary ms-1 agregar-producto'>
                                            <i class="fa-solid fa-circle-plus"></i>
                                        </button>
                                        <button class='btn btn-outline-secondary ms-1 pagar'>
                                            <i class="fa-solid fa-sack-dollar"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>   
                        </div>
                        `;
                    cardMenu.innerHTML += card;
                });
            });

    }

    cardMenu.addEventListener("click", (e) => {        
        const card = e.target.closest(".card");
        
        if(card && !e.target.closest('.btn')){
            if(card.dataset.status === "D"){
                document.querySelector("#form-orden-nueva").reset();
                document.querySelector("#md-tabla-datalle tbody").innerHTML ="";

                document.querySelector("#md-mesa").dataset.idmesa = card.dataset.idmesa;
                document.querySelector("#md-mesa").value = card.querySelector("h4").textContent;
                MDOrdennuevo.toggle();
            }            
        }

        if(
            e.target.classList.contains("detalle") ||
            e.target.parentElement.classList.contains("detalle")
        ){                        
            if(card.dataset.status === 'O'){
                cargarDetalle(card.dataset.idmesa);
            }
        }  

        if(    
            e.target.classList.contains("agregar-producto") ||
            e.target.parentElement.classList.contains("agregar-producto")
        ){
            if(card.dataset.status === 'O'){
                MDAgproducto.toggle();
            }
        }        
    }) 


    function cargarDetalle(idmesa){
        const pm = new URLSearchParams();
        pm.append("operacion", "VentaxMesa");
        pm.append("idmesa", idmesa) 
        fetch("../controllers/Orden.controller.php",{
            method: 'POST',
            body: pm
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
                    .then((response)=>{
                        const res = response[0].json();
                        const res1 = response[1].json();
                        return Promise.all([res,res1]);
                    })
                    .then((datos)=>{
                        const busca =  datos[0];
                        const detalle = datos[1];

                        document.querySelector("#md-dt-fecha").value = busca.fechahoraorden;
                        document.querySelector("#md-dt-mesa").value = busca.numesa;
                        document.querySelector("#md-dt-empleado").value= busca.Empleado;
                        document.querySelector("#dt-tabla-datalle tbody").innerHTML="";
                        let total =0.0;
                        let fila = 1;

                        detalle.forEach(element =>{
                            const fil =`
                                <tr>
                                    <td>${fila}</td>
                                    <td>${element.nombreproducto}</td>
                                    <td>${element.cantidad}</td>
                                    <td>${element.precio}</td>
                                    <td>${element.Importe}</td>
                                </tr>
                            `;
                            fila++;
                            document.querySelector("#dt-tabla-datalle tbody").innerHTML+= fil;
                            total += parseFloat(element.Importe);
                        });

                        document.querySelector("#md-dt-total").value = total.toFixed(2);

                        MDDetalle.toggle();
                    })
                    .catch((error) =>{
                        console.log(error);
                        alert("Problemas");
                    });
                })
    }

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
                    opmd.setAttribute("data-precio", element.precio);
                    document.querySelector("#md-producto").appendChild(opmd);

                    const opag = document.createElement("option");
                    opag.textContent = element.nombreproducto;
                    opag.value = element.idproducto;
                    opag.setAttribute("data-precio", element.precio);
                    document.querySelector("#ag-producto").appendChild(opag);
                    
                });                
            });
    }

    function aggdetalletabla(){
        if(
            !document.querySelector("#md-producto").value ||
            !document.querySelector("#md-cantidad").value ||
            !document.querySelector("#md-precio").value ||
            !document.querySelector("#md-total").value 
        ){
            alert("Seleccione un producto")

        }else{
            const MDproducto = document.querySelector("#md-producto");
            const MDcantidad = document.querySelector("#md-cantidad");
            const MDprecio = document.querySelector("#md-precio");
            const MDtotal = document.querySelector("#md-total");

            let cuerpotabla = document.querySelectorAll("#md-tabla-datalle tbody");

            let filas = Array.from(cuerpotabla[0].children);

            let filaexiste = filas.find((fila)=>{
                let productoNombre = fila.cells[1].innerText;
                return(
                    productoNombre === MDproducto.options[MDproducto.selectedIndex].text
                );
            });
            
            if(filaexiste){
                let NombreProducto = filaexiste.cells[1].textContent;
                let OpcionProducto = Array.from(MDproducto.options).find(
                    (option) => option.text === NombreProducto
                );

                let cantidad = parseInt(filaexiste.cells[2].innerText) + parseInt(MDcantidad.value);                
            }else{                
                let nuevafila = `
                <tr data-idproducto='${MDproducto.value}'>
                    <td>${filas.length + 1}</td>
                    <td>${MDproducto.options[MDproducto.selectedIndex].text}</td>
                    <td>${MDcantidad.value}</td>
                    <td>${MDprecio.value}</td>
                    <td>${MDtotal.value}</td>
                    <td>
                        <a type="button class="btn btn-sm me-1 md-eliminar"><i class="fa-regular fa-trash"></i></a>    
                        <a type="button class="btn btn-sm me-1 md-quitar"><i class="fa-solid fa-minus"></i></a>
                        <a type="button class="btn btn-sm me-1 md-añadir"><i class="fa-solid fa-plus"></i></a>
                    </td>
                </tr>
                `;
                document.querySelector("#md-tabla-datalle tbody").innerHTML += nuevafila;
            }
            MDAgproducto.selectedIndex=0;
            MDcantidad.value= "1";
            MDprecio.value= "";
            MDtotal.value= "";

            calculaImporte();
        }
    }

    function calculaImporte(){
        let CuerpoTabla = document.querySelectorAll("#md-tabla-datalle tbody");
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
            !document.querySelector("#md-tabla-datalle tbody").childElementCount
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
                    .then((res)=>res.json())
                    .then((datos)=>{
                        if(datos.success){
                            let tablacuerpo = querySelectorAll("#md-tabla-detalle tbody");
                            let filatabla = Array.from(tablacuerpo[0].children);

                            filatabla.forEach((element)=>{
                                const parametro = new URLSearchParams();
                                parametro.append("operacion", "registrardetalleorden");
                                parametro.append("idproducto",element.dataset.idproducto);
                                parametro.append("cantidad", element.cells[2].textContent);
                                fetch("../controllers/Orden.controller.php",{
                                    method: 'POST',
                                    body: parametro
                                })
                            });

                            const pm = new URLSearchParams();
                            pm.append("operacion", "cambiarestado");
                            pm.append("idmesa",document.querySelector("#md-mesa").dataset.idmesa);
                            pm.append("estado", "O");
                            fetch("../controllers/Mesa.controller.php",{
                                method: 'POST',
                                body: pm
                            })
                            MDOrdennuevo.toggle();
                            document.querySelector("#form-orden-nueva").reset();
                            document.querySelector("#md-tabla-datalle tbody").innerHTML="";
                            renderData();
                        }else{
                            alert(datos.message);
                        }
                    });

            }

        }

    }


    function aggdetalle(idorden){
        if(
            !document.querySelector("#ag-producto").value ||
            !document.querySelector("#ag-cantidad").value ||
            !document.querySelector("#ag-precio").value ||
            !document.querySelector("#ag-total").value             
        ){
            alert("Seleccione un producto")
        }else{
            if(confirm("¿Desea registrar este pedido?")){
                const parametros = new URLSearchParams();
                parametros.append("operacion","registrar");
                parametros.append("idorden", idorden);
                parametros.append("idproducto", document.querySelector("#ag-producto").value);
                parametros.append("cantidad", document.querySelector("#ag-cantidad").value);
                fetch("../controllers/Detalle_Orden.php",{
                    method: 'POST',
                    body: parametros
                })  
                    .then(res => res.json())
                    .then(datos =>{
                        if(datos){
                            document.querySelector("#md-agproducto").reset();
                            MDAgproducto.toggle();
                        }else{
                            alert(datos.message);
                        }
                    })
            }            
        }

    }

  /*   cardMenu.addEventListener("click", (e)=>{
        if(
            e.target.classList.contains("detalle") ||
            e.target.parentElement.classList.contains("detalle")
        ){
            const detalleboton = e.target.closest(".detalle");
            const idorden = detalleboton? detalleboton.dataset.idorden : e.target.parentElement.dataset.idorden;
            cargarDetalle(idorden);
        }
        if(
            e.target.classList.contains("agregar-producto") ||
            e.target.parentElement.classList.contains("agregar-producto")
        ){
            const trel = e.target.closest("tr");
            const dts = trel.querySelectorAll("td");
            const tdant = dts[dt.length - 2];
            const contenant = tdant.textContent.trim();

            if(contenant === "Pendiente"){
                const agboton = e.target.closest(".agregar-producto");

                idorden = agboton ? agboton.dataset.idorden : e.target.parentElement.dataset.idorden;
                MDAgproducto.toggle();
            }else{
                alert("La Orden esta finalizada");
            }
        }
        if(
            e.target.classList.contains("cambiar-estado") ||
            e.target.parentElement.classList.contains("cambiar-estado")
        ){
            MDCambiar.toggle();
        }
    }); */

    document.querySelector("#md-producto").addEventListener("change", (e) => {
        const opcion = e.target.options[e.target.selectedIndex];

        const precio = parseFloat(opcion.dataset.precio).toFixed(2);

        document.querySelector("#md-precio").value = precio;
        if (document.querySelector("#md-cantidad").value > 0){
            const total = (parseInt(document.querySelector("#md-cantidad").value) * precio).toFixed(2);            

            document.querySelector("#md-total").value = total;
        }
    });

    document.querySelector("#md-cantidad").addEventListener("input", (e)=>{
        const cantidad = parseInt(e.target.value);
        const productoselect = document.querySelector("#md-producto");
        if(!productoselect.value) return;

        const precio = parseFloat(document.querySelector("#md-precio").value);
        
        if (cantidad > 0){
            const total = (cantidad * precio).toFixed(2);
            document.querySelector("#md-total").value = total;
        }else{
            document.querySelector("#md-total").value="";
        }        
    });

    document.querySelector("#md-producto-agregar").addEventListener("click", aggdetalletabla);

    document.querySelector("#ag-producto").addEventListener("change", (e)=>{
        const opcion = e.target.options[e.target.selectedIndex];

        const precio = parseFloat(opcion.dataset.precio).toFixed(2);

        document.querySelector("#ag-precio").value = precio;
        if (document.querySelector("#ag-cantidad").value > 0){
            const total = (parseInt(document.querySelector("#ag-cantidad").value) * precio).toFixed(2);            

            document.querySelector("#ag-total").value = total;
        }
    });

    document.querySelector("#ag-cantidad").addEventListener("input", (e)=>{
        const cantida = parseInt(e.target.value);
        const seleprod = document.querySelector("#ag-producto");
        if(!seleprod.value) return;
        const prec = parseFloat(document.querySelector("#ag-precio").value);
        
        if(cantida > 0){
            const tota =(cantida * prec).toFixed(2);
            document.querySelector("#ag-total").value= tota;
        }else{
            document.querySelector("#ag-total").value ="";
        }        
    });

    document
        .querySelector("#ag-agregar")
        .addEventListener("click", ()=>{
            aggdetalle(idorden);
        });
    
    document.querySelector("#md-tabla-datalle tbody").addEventListener("click", (e)=>{
        if(
            e.target.classList.contains("md-eliminar") ||
            e.target.parentElement.classList.contains("md-eliminar")
        ){
            const fila = e.target.closest("tr");
            fila.remove();
            calculaImporte();
        }
        if(
            e.target.classList.contains("md-quitar") ||
            e.target.parentElement.classList.contains("md-quitar")
        ){
            const  fila = e.target.closest("tr");
            fila.cells[2].textContent = parseInt(fila.cells[2].textContent) - 1;
            fila.cells[4].textContent = (parseInt(fila.cells[2].textContent) * parseFloat(fila.cells[3].textContent)).toFixed(2);
            if (parseInt(fila.cells[2].textContent) <= 0){
                fila.remove();
            }
            calculaImporte();
        }
        if(
            e.target.classList.contains("md-añadir") ||
            e.target.parentElement.classList.contains("md-añadir")
        ){
            const fila = e.target.closest("tr");
            const nombrepro = fila.cells[1].textContent;

            let options = document.querySelector("#md-producto").options;

            for(let i = 0; i < options.length; i++){
                if(options[i].text === nombrepro){
                    break;
                }
            }
            fila.cells[2].textContent = parseInt(fila.cells[2].textContent) + 1;
            fila.cells[4].textContent = (parseInt(fila.cells[2].textContent) * parseFloat(fila.cells[3].textContent)).toFixed(2);
            calculaImporte();               
        }
        
    });

    document.querySelector("#registrar")
        .addEventListener("click", RegistrarOrden);



    
    //

    renderData();
    listarProductos();
    ListarEmpleados();
    
});