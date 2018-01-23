<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  private $users = 'users';

  public function get($user) {
    return $this->_read($this->users, array('where' => $user));
  }
}

?>
