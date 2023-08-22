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
              <a href="https://mycitra.telkom.co.id/cron/generatePdfDjpbCustom" class="nav-link">
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
    <!-- Main content, tempat menampilkan iframe -->
    <div class="content-wrapper">
            <iframe id="contentIframe" width="100%" height="600px" style="border:none;"></iframe>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
    const iframe = document.getElementById('contentIframe');

    document.querySelector('.nav-link[href="https://mycitra.telkom.co.id/cron/generatePdfDjpbCustom"]').addEventListener('click', function(e) {
        e.preventDefault();
        iframe.src = this.href;
        iframe.style.display = 'block'; // Tampilkan iframe
    });

    // Sembunyikan iframe untuk tautan lainnya
    const otherLinks = document.querySelectorAll('.nav-link:not([href="https://mycitra.telkom.co.id/cron/generatePdfDjpbCustom"])');
    otherLinks.forEach(link => {
        link.addEventListener('click', function() {
            iframe.style.display = 'none'; // Sembunyikan iframe
        });
    });
});
        </script>
    </div>
</body>
   