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
    public function generate_data(): string
    {
        $header = view('layout/header');

        // Muat view untuk halaman 'pages/tampilan'
        $content = view('pages/generate_data');
    

        $footer = view('layout/footer');

        // Gabungkan semua view menjadi satu
        $fullView = $header . $content . $footer;

        return $fullView;
    }
    public function generate_pdf(): string
    {
        $header = view('layout/header');

        // Muat view untuk halaman 'pages/tampilan'
        $content = view('pages/generate_pdf');
    

        $footer = view('layout/footer');

        // Gabungkan semua view menjadi satu
        $fullView = $header . $content . $footer;

        return $fullView;
    }
    public function stamp(): string
    {
        $header = view('layout/header');

        $content = view('pages/stamp');

        $footer = view('layout/footer');

        $fullView = $header . $content . $footer;

        return $fullView;
    } 
    public function report(): string
    {
        $header = view('layout/header');

        $content = view('pages/report');

        $footer = view('layout/footer');

        $fullView = $header . $content . $footer;

        return $fullView;
    }
}
