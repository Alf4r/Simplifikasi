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
              <h1 class="m-0 text-dark">DATA</h1>
            </div>
            <!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Generate Data</li>
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
                  <h3>0</h3>

                  <p>Belum Di generate</p>
                </div>
                <div class="icon">
                  <i class="ion ion-android-contacts"></i>
                </div>
              </div>
            </div>
          
            <!-- ./col -->
            <div class="col-lg-3 col-6">
              <!-- small box -->
              <div class="small-box bg-warning">
                <div class="inner">
                  <h3 id="GenerateValue">0</h3> <!-- Tempat menampilkan count dari halaman Stamp PDF -->
                  <p>Telah Di generate</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
              </div>
            </div>
            <!-- ./col -->

            <!-- small box -->

            <!-- ./col -->
            <div class="col-md-7">
    <div class="card">
        <div class="card-header p-1">
            <ul class="nav nav-pills">
                <li class="nav-item">
                    <a class="nav-link active" href="#activity" data-toggle="tab">Step 1</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#timeline" data-toggle="tab">Step 2</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step3" data-toggle="tab">Step 3</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step4" data-toggle="tab">Step 4</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step5" data-toggle="tab">Step 5</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step6" data-toggle="tab">Step 6</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step7" data-toggle="tab">Step 7</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#step8" data-toggle="tab">Step 8</a>
                </li>
            </ul>
        </div>
        <div class="card-body">
        <div class="tab-content">
    <!-- Step 1 -->
    <div class="tab-pane active" id="step1">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button" id="step1">next</button>
        </div>
        <script>
          const nextButton = document.getElementById('step1');
          let count = localStorage.getItem('GenerateValue') ? parseInt(localStorage.getItem('GenerateValue')) : 0; 
          const countDisplay = document.getElementById('GenerateValue');  // Dapatkan elemen untuk menampilkan nilai count
          countDisplay.innerText = count;  // Atur tampilan awal dengan nilai count saat ini

          nextButton.addEventListener("click", function() {
              // Tambahkan 1 ke nilai count setiap kali tombol ditekan
              count++;
              localStorage.setItem('GenerateValue', count);  // Simpan nilai count ke localStorage
              countDisplay.innerText = count;

            });
        </script>
    </div>
    <!-- Step 2 -->
    <div class="tab-pane" id="step2">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 3 -->
    <div class="tab-pane" id="step3">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 4 -->
    <div class="tab-pane" id="step4">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 5 -->
    <div class="tab-pane" id="step5">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 6 -->
    <div class="tab-pane" id="step6">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 7 -->
    <div class="tab-pane" id="step7">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    </div>
    <!-- Step 8 -->
    <div class="tab-pane" id="step8">
        <div class="progress">
            <div class="progress__fill" style="background-color: lightblue;"></div>
            <span class="progress__text">0%</span>
        </div>
        <div class="button">
            <button type="button">next</button>
        </div>
    
</div>
<script>
const nextButtons = document.querySelectorAll('.button button');
const allSteps = ['step1', 'step2', 'step3', 'step4', 'step5', 'step6', 'step7', 'step8'];
let currentStepIndex = 0;
let percentage = 0;

nextButtons.forEach((button, index) => {
    button.addEventListener("click", function() {

        // Pemanggilan ke QueryController
        fetch(`/next-query/${currentStepIndex + 1}`) // +1 karena indeks dimulai dari 0 tetapi query kita mulai dari 1
        .then(response => response.json())
        .then(data => {
            // Proses respons dari server (jika diperlukan)

            percentage += 12.5;

            const currentProgressFill = document.querySelector(`#${allSteps[currentStepIndex]} .progress__fill`);
            const currentProgressText = document.querySelector(`#${allSteps[currentStepIndex]} .progress__text`);
            currentProgressFill.style.width = percentage + "%";
            currentProgressText.textContent = Math.round(percentage) + "%";

            if (percentage >= 100 && currentStepIndex < allSteps.length - 1) {
                const nextStepTab = document.querySelector(`a[href="#${allSteps[currentStepIndex + 1]}"]`);
                nextStepTab.click();
                currentStepIndex++;

                const nextProgressFill = document.querySelector(`#${allSteps[currentStepIndex]} .progress__fill`);
                const nextProgressText = document.querySelector(`#${allSteps[currentStepIndex]} .progress__text`);
                nextProgressFill.style.width = "0%";
                nextProgressText.textContent = "0%";
                
                percentage = 0;
            }
        })
        .catch(error => {
            console.error("Terjadi kesalahan saat memproses data:", error);
        });
    });
});

</script>  

                <!-- Anda dapat menyesuaikan animasi untuk step-step selanjutnya di sini. 
                     Saya tidak menambahkan animasi untuk step lainnya di contoh ini,
                     Anda dapat menambahkan sesuai keinginan Anda. -->
            </div>
        </div>
    </div>
</div>

              <!--/card-header-->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="activity">
                    <style>
                      .progress {
                        position: relative;
                        width: 500px;
                        height: 30px;
                        background-color: white;
                        border-radius: 5px;
                        overflow: hidden;
                      }

                      .progress__fill {
                        width: 0%;
                        height: 100%;
                        background-color: lightblue;
                      }

                      progress__text {
                        position: absolute;
                        top: 0%;
                        right: 5px;
                        transform: translateY(-50%);
                      }
                    </style>
                    <!-- /.row -->

                    <style>
                      .progress {
                        position: relative;
                        width: 500px;
                        height: 30px;
                        background-color: white;
                        border-radius: 5px;
                        overflow: hidden;
                      }

                      .progress__fill {
                        width: 0%;
                        height: 100%;
                        background-color: lightblue;
                      }

                      progress__text {
                        position: absolute;
                        top: 50%;
                        right: 5px;
                        transform: translateY(-50%);
                      }

                      .button {
                        margin: 0;
                        position: absolute;
                        top: 70%;
                        left: 80%;
                        background-color: lightblue;
                        border-radius: 5px;
                      }

                      .column {
                        float: left;
                        width: 800px;
                        padding: 10px;
                        height: 150px;
                        background-color: whitesmoke;
                        border-style: solid;
                        border-color: grey;
                        border-radius: 5px;
                      }
                    </style>
                        <!-- Main row -->
                        <div class="row">
                          <!-- Left col -->
                          <section class="col-lg-7 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->

                            <!-- /.card-header -->

                            </tr>
                            </tbody>
                            </table>

                            </p>
                            <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 130px">
                              <canvas id="revenue-chart-canvas" height="300" style="height: 300px"></canvas>
                            </div>
                            <div class="chart tab-pane" id="sales-chart" style="position: relative; height: 300px">
                              <canvas id="sales-chart-canvas" height="300" style="height: 300px"></canvas>
                            </div>
                        </div>
                      </div>
                      <!-- /.card-body -->
                    </div>

      </section>
      <section class="col-lg-5 connectedSortable">
        <!-- Map card -->
        <!-- card tools -->
        <div class="card-tools">
          <button type="button" class="btn btn-primary btn-sm" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
            <i class="fas fa-minus"></i>
          </button>
        </div>
        <!-- /.card-tools -->


        <!-- right col -->
    </div>
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