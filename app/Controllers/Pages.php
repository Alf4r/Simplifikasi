<?php

namespace App\Controllers;

class Pages extends BaseController
{
    public function index(): string
    {
        $header = view('layout/header');

        // Muat view untuk halaman 'pages/tampilan'
        $content = view('pages/tampilan');

        $footer = view('layout/footer');

        // Gabungkan semua view menjadi satu
        $fullView = $header . $content . $footer;

        return $fullView;
    }
}
