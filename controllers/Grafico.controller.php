<?php

require_once '../models/Grafico.model.php';

if (isset($_POST['operacion'])) {
    $grafico = new Grafico();

    if ($_POST['operacion'] == 'graficof') {
        $datos = $grafico->graficof();
        echo json_encode($datos);
    }

    if ($_POST['operacion'] == 'graficose') {
        $datos = $grafico->graficose();
        echo json_encode($datos);
    }

}
