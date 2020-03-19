<?php

class User
{

  private $userID;
  private $loggedin;
  private $username;
  private $firstname;
  private $lastname;
  private $roleName;

  public function fetchUserInfo($_userID) {
    global $connection;
    $sql = "SELECT `user`.`userID`, `user`.`username`, `user`.`userpassword`, `user`.`firstname`, `user`.`lastname`, `location`.`locationName`, `role`.`roleName` ";
    $sql .= "FROM `user` ";
    $sql .= "JOIN `location` ON `user`.`locationID` = `location`.`locationID` ";
    $sql .= "JOIN `role` ON `user`.`roleID` = `role`.`roleID` ";
    $sql .= "WHERE (`user`.`userID` = ?)";
    if ($stmt = $connection->prepare($sql)) {
      $stmt->bind_param("i", $_userID);
      $stmt->execute();
      $stmt->store_result();
      
      if ($stmt->num_rows == 1) {
        $stmt->bind_result($userID, $username, $userpassword, $firstname, $lastname, $locationName, $roleName);
        
        if ($stmt->fetch()) {
          $this->userID = $userID;
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
      } else {
        $this->outputSuccess("User Information Updated.");
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
          $sql = "UPDATE `user` SET `user`.`userpassword` = ? ";
          $sql .= "WHERE `user`.`userID` = ?";
          unset($stmt); //uninitialize $stmt var as used multiple times in single function
          if ($stmt = $connection->prepare($sql)) {
            $stmt->bind_param("si", $newPassword, $this->userID);

            if (!$stmt->execute()) {
              $this->outputError("Error: ".$stmt->errno);
            } else {
              $this->outputSuccess("Password Updated.");
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

  /* method @output($operationResult, $msg)
   * param:
   * $operationResult(string) : success, failed
   * $msg(string) : message to be output to users
  */

  private function output($operationResult, $msg) {
    switch ($operationResult) {
      case 'success':
        return "<div class='alert alert-success' role='alert'> 
                <strong>$msg</strong>
                </div>";
        break;
      
      case 'failed':
        return "<div class='alert alert-danger' role='alert'> 
                <strong>Operation failed. $msg</strong>
                </div>";

      default:
        return "Unknown Operation Result";
        break;
    }
  }

  private function outputError($msg) {
    echo $this->output('failed', $msg);
  }

  private function outputSuccess($msg) {
    echo $this->output('success', $msg);
  }
}
?>