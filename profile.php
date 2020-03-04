<?php
include('config.php');
include('inc/layout/header.php');
include(CLASS_DIR.'/class.user.php');
$user = new User;
$user->fetchUserInfo($_SESSION['userID']);

if (isset($_POST['editUserInfoSubmitBtn'])) {
  $user->updateUserInfo($_POST);
}

/* not checking for element name editUserInfoSubmitBtn as the form is submitted by script.
Refer: https://stackoverflow.com/questions/1709301/javascript-submit-does-not-include-submit-button-value
*/
if (isset($_POST['currentpassword'])) {
  $user->updatePassword($_POST);
}
?>

<h3>Profile</h3>

<div class="card text-center">
  <div class="card-header">
    <ul class="nav nav-tabs card-header-tabs" id="userTab" role="tablist">
      <li class="nav-item">
        <a class="nav-link active" href="#user" id="userinfo" data-toggle="tab">User Information</a>
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
        <form action="" method="post" id="userInfoForm">
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="username">Username</label>
            </div>
            <div class="col-sm-6">
              <input type="text" name="username" id=username class="form-control" placeholder="" value="<?php echo $user->username();?>" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="firstname">First Name</label>
            </div>  
            <div class="col-sm-6">
              <input type="text" name="firstname" id="firstname" class="form-control" placeholder="" value="<?php echo $user->firstname();?>" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-2">
              <label for="lastname">Last Name</label>
            </div>
            <div class="col-sm-6">
              <input type="text" name="lastname" id="lastname" class="form-control" placeholder="" value="<?php echo $user->lastname();?>" disabled>
            </div>
          </div>
            <div class="form-group-row">
              <div class="col">
                  <a href="#" onclick="editUserInfo()" class="float-left btn btn-primary" id="editUserInfoBtn" name="editUserInfoBtn">Edit</a>
                  <input type="submit" class="ml-3 float-left btn btn-success" name="editUserInfoSubmitBtn" id="editUserInfoSubmitBtn" style="display: none" value="Update User Info">
              </div>
            </div>
        </form>
      </div>
      <div class="tab-pane fade" id="auth" role="tabpanel">
      <form action="" method="post" id="userPasswordForm">
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="currentpassword">Current Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="currentpassword" id="currentpassword" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="newpassword">New Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="newpassword" id="newpassword" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-3">
              <label for="verifypassword">Verify Password</label>
            </div>  
            <div class="col-sm-6">
              <input type="password" name="verifypassword" id="verifypassword" class="form-control" placeholder="" value="" disabled>
            </div>
          </div>
            <div class="form-group-row">
              <div class="col">
              <a href="#" onclick="editPassword()" class="float-left btn btn-primary" id="editPasswordBtn" name="editPasswordBtn">Edit</a>
              <a href="#" onclick="updatePassword()" class="ml-3 float-left btn btn-success" name="editPasswordSubmitBtn" id="editPasswordSubmitBtn" style="display: none">Update Password</a>
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

<script>
function editUserInfo() {
  var x = document.getElementById("username").disabled;
  if (x == true) {
    document.getElementById("username").disabled = false;
    document.getElementById("firstname").disabled = false;
    document.getElementById("lastname").disabled = false;
    document.getElementById("editUserInfoSubmitBtn").style.display="block";
    document.getElementById("editUserInfoBtn").innerHTML = "Cancel";
    document.getElementById("editUserInfoBtn").className = "float-left btn btn-danger";

  } else {
    document.getElementById("username").disabled = true;
    document.getElementById("firstname").disabled = true;
    document.getElementById("lastname").disabled = true;
    document.getElementById("editUserInfoSubmitBtn").style.display="none";
    document.getElementById("editUserInfoBtn").innerHTML = "Edit";
    document.getElementById("editUserInfoBtn").className = "float-left btn btn-primary";
  }
}

function editPassword() {
  var x = document.getElementById("currentpassword").disabled;
  if (x == true) {
    document.getElementById("currentpassword").disabled = false;
    document.getElementById("newpassword").disabled = false;
    document.getElementById("verifypassword").disabled = false;
    document.getElementById("editPasswordSubmitBtn").style.display="block";
    document.getElementById("editPasswordBtn").innerHTML = "Cancel";
    document.getElementById("editPasswordBtn").className = "float-left btn btn-danger";
  } else {
    document.getElementById("currentpassword").disabled = true;
    document.getElementById("newpassword").disabled = true;
    document.getElementById("verifypassword").disabled = true;
    document.getElementById("editPasswordSubmitBtn").style.display="none";
    document.getElementById("editPasswordBtn").innerHTML = "Edit";
    document.getElementById("editPasswordBtn").className = "float-left btn btn-primary";
  }
}

function updatePassword() {
  var currentpassword = document.forms["userPasswordForm"]["currentpassword"];
  var newpassword = document.forms["userPasswordForm"]["newpassword"];
  var verifypassword = document.forms["userPasswordForm"]["verifypassword"];
  
  if (currentpassword.value == "") {
    window.alert("Current password is empty");
    currentpassword.focus();
  } else if (newpassword.value != verifypassword.value || newpassword.value == "" || verifypassword.value == "") {
    window.alert("Password not same!");
    verifypassword.focus();
  } else {
    document.forms["userPasswordForm"].submit();
  }
}
</script>

<?php
include('inc/layout/footer.php');
?>