<nav class="navbar navbar-expand-md navbar-light bg-light">
      <a class="navbar-brand" href="index.php">Prodata CM Tracking Application</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="index.php">Home<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" >Asset</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="assets.php?action=add">Add Asset</a>
              <a class="dropdown-item" href="assets.php">Assets List</a>
              <a class="dropdown-item" href="assets.php?action=archived">Archived List</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" >Spare Parts</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="">Add Spareparts</a>
              <a class="dropdown-item" href="">Spareparts List</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0" method="post" action="search.php">
          <input class="form-control mr-sm-2" type="text" placeholder="Search Serial" name="search">
        </form>
        <div>
        <i class="fa fa-user fa-lg" aria-hidden="true"></i>
        </div>
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="profile.php">Hi, <?php echo ucfirst($_SESSION['username']); ?></a>
            <div class=" mr-1 dropdown-menu dropdown-menu-right">
              <a class="dropdown-item" href="">Maintenance</a>
              <a class="dropdown-item" href="">Profile</a>
              <a class="dropdown-item" href="logout.php">Logout</a>
            </div>
          </li>
        </ul>
      </div>
    </nav>

    <main role="main" class="container">