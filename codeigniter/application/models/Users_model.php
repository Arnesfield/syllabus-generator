<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users_model extends MY_Custom_Model {

  public function get($user = NULL) {
    $this->db->from('users');

    if ($user) {
      $this->db->where($user);
    }

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($user) {
    return $this->_create('users', $user);
  }

  public function insertMultiple($users) {
    return $this->db->insert_batch('users', $users);
  }
}

?>
