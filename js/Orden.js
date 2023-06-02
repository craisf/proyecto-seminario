document.addEventListener("DOMContentLoaded", ()=>{
    const cardMenu = document.querySelector("#container-card");    
    const MDOrdennuevo = new bootstrap.Modal(
        document.querySelector("#modal-orden")
    );



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
            .then((res) =>res.json())
            .then(datos=>{
                datos.forEach((element) =>{
                    const option = document.createElement("option");
                    option.textContent = element.nombre + " " + element.apellido;
                    option.value = element.idempleado;
                    document.getElementById('md-empleados').appendChild(option);
                })
            })
    }

    

    ListarEmpleados();
    renderData();
})