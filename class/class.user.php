<?php

class User
{

  private $userID;
  private $loggedin;
  private $username;
  private $firstname;
  private $lastname;
  private $roleName;

  public function __construct()
  {
    $this->userID = $_SESSION['userID'];
    $this->fetch_user_info($this->userID);
  }

  public function fetch_user_info($_userID) {
    global $connection;
    $sql = "SELECT `user`.`username`, `user`.`userpassword`, `user`.`firstname`, `user`.`lastname`, `location`.`locationName`, `role`.`roleName` ";
    $sql .= "FROM `user` ";
    $sql .= "JOIN `location` ON `user`.`locationID` = `location`.`locationID` ";
    $sql .= "JOIN `role` ON `user`.`roleID` = `role`.`roleID` ";
    $sql .= "WHERE (`user`.`userID` = ?)";
    if ($stmt = $connection->prepare($sql)) {
      $stmt->bind_param("i", $_userID);
      $stmt->execute();
      $stmt->store_result();
      
      if ($stmt->num_rows == 1) {
        $stmt->bind_result($username, $userpassword, $firstname, $lastname, $locationName, $roleName);
        
        if ($stmt->fetch()) {
          $this->username = $username;
          $this->userpassword = $userpassword;
          $this->firstname = $firstname;
          $this->lastname = $lastname;
          $this->locationName = $locationName;
          $this->roleName = $roleName;
        }
      }
    }
  }
  
  public function username() {
    return $this->username;
  }

  public function setUsername($username) {
    $this->username = $username;
  }

  public function userpassword() {
    return $this->userpassword;
  }

  public function firstname() {
    return $this->firstname;
  }

  public function setFirstname($firstname) {
    $this->firstname = $firstname;
  }

  public function lastname() {
    return $this->lastname;
  }

  public function setLastname($lastname) {
    $this->lastname = $lastname;
  }

  public function role() {
    return $this->roleName;
  }

  public function updateUserInfo($request) {
    global $connection;
    
    $this->username = $request['username'];
    $this->firstname = $request['firstname'];
    $this->lastname = $request['lastname'];

    $sql = "UPDATE `user` SET `user`.`username` = ?, `user`.`firstname` = ?, `user`.`lastname` = ? ";
    $sql .= "WHERE `user`.`userID` = ?";
    if ($stmt = $connection->prepare($sql)) {
      $stmt->bind_param("sssi", $this->username, $this->firstname, $this->lastname, $this->userID);
      
      if (!$stmt->execute()) {
        $this->outputError("Error: ".$stmt->errno);
      }
    }
  }

  public function updatePassword($request) {
    global $connection;

    $currentPassword = $request['currentpassword'];
    $newPassword = $request['newpassword'];

    //query current password for user
    $sql = "SELECT `user`.`userpassword` FROM `user` ";
    $sql .= "WHERE `user`.`userID` = ?";

    if ($stmt = $connection->prepare($sql)) {
      $stmt->bind_param("i", $this->userID);
      
      if ($stmt->execute() == true) {
        $stmt->bind_result($db_currentpassword);
        $stmt->fetch();
        if ($db_currentpassword !== $currentPassword) {
          $this->outputError("Current password incorrect.");
        } else {
          $sql = "UPDATE `user`.`userpasword` SET `user`.`userpassword` = ? ";
          $sql .= "WHERE `user`.`userID` = ?";
          unset($stmt); //uninitialize $stmt var as used multiple times in single function
          if ($stmt = $connection->prepare($sql)) {
            $stmt->bind_param("si", $newPassword, $this->userID);

            if (!$stmt->execute()) {
              $this->outputError("Error: ".$stmt->errno);
            }
          } else {
            $this->outputError("Error: ".$connection->errno);
          }
        }
      }
    } else {
      $this->outputError("Error: $stmt->errno");
    }
    

  }

  private function outputError($param) {
    echo "<div class='alert alert-danger' role='alert'>";
    echo "<strong>Operation failed. $param</strong>";
    echo "</div>";
  }
}
?>