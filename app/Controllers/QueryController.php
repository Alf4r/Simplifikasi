<?php namespace App\Controllers;

use CodeIgniter\Controller;

class QueryController extends Controller {

    public function index() {
        return view('your_view_name'); // gantikan dengan nama view Anda
    }

    public function loadNextQuery($queryNumber) {
        // Kode untuk menghubungkan ke database Anda
        $DBHOST    = '10.60.180.6';
        $DBPORT    = '1521';
        $DBSERNAME = 'pdb_dev.telkom.co.id';

        $host = '(DESCRIPTION=
          (ADDRESS=
         (PROTOCOL=TCP)
         (HOST='.$DBHOST.')
         (PORT='.$DBPORT.')
          )
          (CONNECT_DATA=
           (SERVER=DEDICATED)
         (SERVICE_NAME='.$DBSERNAME.')
         )
        )';
        $db = \Config\Database::connect();

        // Contoh memuat file SQL dari direktori tertentu
        $filePath = realpath("simplifikasi/app/Database/script" . $queryNumber . ".sql");

        if (!$filePath || !file_exists($filePath)) {
            // handle error, file tidak ditemukan
        }
         // Gantikan path dengan path sebenarnya

        $query = file_get_contents($filePath);

        $result = $db->query($query);
        return json_encode($result->getResult());
    }
}
