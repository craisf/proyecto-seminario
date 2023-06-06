document.addEventListener("DOMContentLoaded",()=>{
    let idproducto =``;    
    const mdproducto = document.querySelector("#nombreProducto");
    const mdecripcion = document.querySelector("#descripcion");
    const mdprecio = document.querySelector("#precio");
    const mdcategoria = document.querySelector("#categoria");
    const table = document.querySelector("#table-producto");
    const cuerpotabla =table.querySelector("tbody");
    
    const btGuardar = document.querySelector("#ag-registrar");
    const btUpdate = document.querySelector("#actualizar")
    const frmProducto = document.querySelector("#form-producto");
    const modal = document.querySelector("#modal-ag-producto");
    const modalU = new bootstrap.Modal(document.querySelector("#md-update"));

   

    function renderData(){
        const pm = new URLSearchParams();
        pm.append("operacion", "listar");
        fetch("../controllers/Producto.controller.php",{
            method: 'POST',
            body: pm
        })
            .then(res =>res.json())
            .then(datos=>{
                cuerpotabla.innerHTML=``;
                datos.forEach(element => {
                    const fila = `
                    <tr>    
                        <td>${element.idproducto}</td>
                        <td>${element.nombreproducto}</td>
                        <td>${element.descripcion}</td>
                        <td>${element.precio}</td>
                        <td>${element.categoria}</td>
                        <td>
                            <a href='#' class='eliminar btn' data-idproducto='${element.idproducto}'><i class="fa-solid fa-trash"></i></a>
                            <a href='#' class='editar btn mt-1' data-idproducto='${element.idproducto}'><i class="fa-solid fa-pen-to-square"></i></a>
                        </td>
                    </tr>
                    `;
                    cuerpotabla.innerHTML+=fila;
                });
            })
        }

        
        function regProducto() {
            if (confirm("¿Está seguro de guardar este Producto?")) {
               const rg = new URLSearchParams();
               rg.append("operacion", "Registrar");
               rg.append("nombreproducto", mdproducto.value);
               rg.append("descripcion", mdecripcion.value);
               rg.append("precio", mdprecio.value);
               rg.append("categoria", mdcategoria.value);
               fetch("../controllers/Producto.controller.php", {
                  method: 'POST',
                  body: rg
               })
               .then(res => res.json())
               .then(datos => {
                  if (datos.status) {
                     renderData();
                     frmProducto.reset();       
                     mdproducto.focus();                                                              
                  } else {
                     alert(datos.message);
                  }
               })
            }
        }                    
    
        function update(){
            if(confirm("¿Esta seguro de Actualizar?")){
                const parametros = new URLSearchParams();
                parametros.append("operacion", "actualizar");
                parametros.append("idproducto", idproducto);
                parametros.append("nombreproducto", document.querySelector("#md-nombreProducto").value);
                parametros.append("descripcion", document.querySelector("#md-descripcion").value);
                parametros.append("precio", document.querySelector("#md-precio").value);
                parametros.append("categoria", document.querySelector("#md-categoria").value);
                fetch("../controllers/Producto.controller.php",{
                    method: 'POST',
                    body: parametros
                })
                    .then(res=>res.json())
                    .then(datos=>{
                        if(datos.status){
                            renderData();
                            modalU.toggle();
                        }else{
                            alert(datos.message);
                        }
                    })
            }
        }       
        
        cuerpotabla.addEventListener("click",(event)=>{
            if(event.target.classList[0] === 'eliminar'){
                if(confirm("¿Esta seguro de eliminar?")){
                    idproducto = parseInt(event.target.dataset.idproducto); 
                    const pm = new URLSearchParams();
                    pm.append("operacion", "eliminar");
                    pm.append("idproducto", idproducto);
                    fetch("../controllers/Producto.controller.php",{
                        method: 'POST',
                        body: pm
                    })
                        .then(res=>res.json())
                        .then(datos=>{                            
                            if(datos.status){
                                renderData();                                
                            }else{
                                alert(datos.message);
                            }
                        });
                }
            }
        });

        cuerpotabla.addEventListener("click", (event) =>{
            if(event.target.classList[0] === 'editar'){
                idproducto = parseInt(event.target.dataset.idproducto);
                const pme = new URLSearchParams();
                pme.append("operacion", "obtener");
                pme.append("idproducto", idproducto);
                fetch("../controllers/Producto.controller.php",{
                    method: 'POST',
                    body: pme
                })
                    .then(res=>res.json())
                    .then(datos=>{  
                        console.log(datos)                      
                        document.querySelector("#md-nombreProducto").value = datos.nombreproducto;
                        document.querySelector("#md-descripcion").value = datos.descripcion;
                        document.querySelector("#md-precio").value = datos.precio;
                        document.querySelector("#md-categoria").value = datos.categoria;

                        modalU.toggle();
                    })
            }
        })
        
        btUpdate.addEventListener("click", update); 
        btGuardar.addEventListener("click", regProducto); 
        renderData();
})