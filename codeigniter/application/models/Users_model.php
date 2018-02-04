<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users_model extends MY_CRUD_Model {

  public function get($user = NULL) {
    $this->db->from('users');

    if ($user) {
      $this->db->where($user);
    }

    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function insert($user) {
    return $this->_create('users', $user);
  }
}

?>
