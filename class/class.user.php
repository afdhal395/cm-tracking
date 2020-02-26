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

  public function userpassword() {
    return $this->userpassword;
  }

  public function firstname() {
    return $this->firstname;
  }

  public function lastname() {
    return $this->lastname;
  }

  public function role() {
    return $this->roleName;
  }
}
?>