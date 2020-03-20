<?php

  /* Input fields:
    username :
    password :
    login :
   */

  if ($_SERVER['REQUEST_METHOD'] == "POST") {
    
    $_username = trim($_POST['username']);
    $_password = trim($_POST['password']);

    if (empty($_username)) {
      $username_err = "Username empty";
    }

    if (empty($_password)) {
      $password_err = "Password empty";
    }

    if (empty($username_err) && empty($password_err)) {
    
      //check username exist or not
      $sql = "SELECT `user`.`userID`, `user`.`username`, `user`.`userpassword`, `user`.`roleID` FROM user WHERE username=?";

      if ($stmt = $connection->prepare($sql)) {
        //bind parameter as string
        $stmt->bind_param("s", $_username);

        //execute sql
        $stmt->execute();

        //store result
        $stmt->store_result();

        //check num_rows returned
        if ($stmt->num_rows == 1) {
          //bind each result column to variable

          $stmt->bind_result($id, $username, $password, $roleID);
          
          //fetch sql result
          if ($stmt->fetch()) {

            //compare string for password, 0 means no differ between both string
            //Milestone: to use password_hash() and verify_password() for better security
            if (strcmp($password, $_password) == 0) {
              
              //create session variable
              session_start();
              $_SESSION['loggedin'] = true;
              $_SESSION['userID'] = $id;
              $_SESSION['username'] = $username;
              $_SESSION['roleID'] = $roleID;

              //redirect to homepage
              header("location: index.php");
            } else {
              //set for error to appear below login form
              $password_err = "Username or password incorrect";
            }
          }
        }
        else {
          //set for error to appear below login form
          $username_err = "Username not found";
        }
      }
    }
  }
?>