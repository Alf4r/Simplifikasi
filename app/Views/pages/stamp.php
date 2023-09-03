<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
      <!-- Left navbar links -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
      </ul>
      <!-- Right navbar links -->
      <ul class="navbar-nav ml-auto"></ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
      <a href="index.html" class="brand-link">
        <img src="dist/img/logo.png" alt="Logo" class="brand-image img-circle elevation-3" style="opacity: 0.8" />
        <span class="brand-text font-weight-light">Simplifikasi</span>
      </a>

      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex"></div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->

            <li class="nav-item">
              <a href="/generate_data" class="nav-link ">
                <i class="far fa-circle nav-icon"></i>
                <p>Generate Data</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="/generate_pdf" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Generate PDF</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="/stamp    " class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Stamp PDF</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="/report" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p>Report</p>
              </a>
            </li>
              </a>
            </li>
          </ul>
        </nav>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0 text-dark">STAMP PDF</h1>
            </div>
            <!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Stamp</li>
              </ol>
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- /.content-header -->

      <!-- Main content -->
      <section class="content">
    <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <div class="col-lg-3 col-6">
                <!-- small box -->
                <div class="small-box bg-info">
                    <div class="inner">
                        <h3 id="countValue">0</h3> <!-- Tambahkan ini untuk menampilkan nilai count -->
                        <p>Count</p>
                    </div>
                </div>
                <!-- Ini adalah tempat tombol 'next' -->
                <div class="button">
                    <button type="button" id="nextButton">next</button>
                    <button type="button" id="resetButton">reset</button>
                </div>
            </div>
            
            <!-- ./col -->
            <div class="col-lg-3 col-6">
                <!-- small box -->
            </div>

            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section class="col-lg-7 connectedSortable">
                    <!-- Custom tabs (Charts with tabs)-->
                    <!-- ... kode lainnya ... -->
                </section>
            </div>
        </div>
</section>


<!-- Script JavaScript -->
<script>
const nextButton = document.getElementById('nextButton');
const resetButton = document.getElementById('resetButton');
const targetURL = 'https://mycitra.telkom.co.id/tte/peruri'; // Ganti dengan URL tujuan Anda

// Coba ambil nilai count dari localStorage. Jika tidak ada, gunakan 0 sebagai nilai default.
let count = localStorage.getItem('countValue') ? parseInt(localStorage.getItem('countValue')) : 0; 

const countDisplay = document.getElementById('countValue');  // Dapatkan elemen untuk menampilkan nilai count
countDisplay.innerText = count;  // Atur tampilan awal dengan nilai count saat ini

nextButton.addEventListener("click", function() {
    // Tambahkan 1 ke nilai count setiap kali tombol ditekan
    count++;
    localStorage.setItem('countValue', count);  // Simpan nilai count ke localStorage
    countDisplay.innerText = count;

    setTimeout(function() {
        window.open(targetURL, '_blank');
    }, 100);
});
resetButton.addEventListener("click", function() {
    count = 0; // Atur ulang count menjadi 0
    localStorage.setItem('countValue', count); // Simpan nilai reset ke localStorage
    countDisplay.innerText = count; // Perbarui tampilan
});
</script>




          

    <!-- /.row (main row) -->
  </div>
  <!-- /.container-fluid -->
  </section>
  <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <footer class="main-footer">

  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
  </div>