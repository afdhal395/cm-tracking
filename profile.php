<?php
include('config.php');
include('inc/layout/header.php');
include(CLASS_DIR.'/class.user.php');
$user = new User;
?>

<h3>Profile</h3>

<div class="card text-center">
  <div class="card-header">
    <ul class="nav nav-tabs card-header-tabs" id="userTab" role="tablist">
      <li class="nav-item">
        <a class="nav-link" href="#user" id="userinfo" data-toggle="tab">User Information</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#auth" id="userauth" data-toggle="tab">Authentication</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#role" id="userrole" data-toggle="tab">Role Information</a>
      </li>
    </ul>
  </div>
  <div class="card-body">
    <div class="tab-content">
      <div class="tab-pane fade show active" id="user" role="tabpanel">
        <form action="" method="post">
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="username">Username</label>
            </div>  
            <div class="col-sm-6">
              <input type="text" name="username" id="" class="form-control" placeholder="" value="<?php echo $user->username();?>" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="firstname">First Name</label>
            </div>  
            <div class="col-sm-6">
              <input type="text" name="firstname" id="" class="form-control" placeholder="" value="<?php echo $user->firstname();?>" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="lastname">Last Name</label>
            </div>  
            <div class="col-sm-6">
              <input type="text" name="lastname" id="" class="form-control" placeholder="" value="<?php echo $user->lastname();?>" disabled>
            </div>
          </div>
            <div class="form-group-row">
              <div class="col">
                <button type="submit" class="float-left btn btn-primary">Edit</button>
              </div>
            </div>
        </form>
      </div>
      <div class="tab-pane fade" id="auth" role="tabpanel">
      <form action="" method="post">
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="currentpassword">Current Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="currentpassword" id="" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="newpassword">New Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="newpassword" id="" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="verifypassword">Verify Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="verifypassword" id="" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
            <div class="form-group-row">
              <div class="col">
                <button type="submit" class="float-left btn btn-primary">Edit</button>
              </div>
            </div>
        </form>
      </div>
      <div class="tab-pane fade" id="role" role="tabpanel">
        <div class="form-group row">
          <div class="col-sm-2">
            <label for="userrole">Role</label>
          </div>
          <div class="col-sm-6">
            <input type="text" class="form-control" name="userrole" id="userrole" value="<?php echo $user->role();?>" aria-describedby="roleHelp" placeholder="" disabled>
            <small id="roleHelp" class="form-text text-muted">Please request promotion if you need it.</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<?php
include('inc/layout/footer.php');
?>