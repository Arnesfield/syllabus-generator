<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users_model extends MY_Custom_Model {

  public function get($user = NULL) {
    $this->db
      ->from('users')
      ->where('status !=', -1);

    if ($user) {
      $this->db->where($user);
    }

    $this->db
      ->order_by('updated_at')
      ->order_by('created_at');

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getByQuery($search) {
    
    $this->db
    ->from('users')
    ->where('status !=', -1);
    
    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          LOWER(fname) LIKE '%$search%' OR
          LOWER(mname) LIKE '%$search%' OR
          LOWER(lname) LIKE '%$search%' OR
          LOWER(username) LIKE '%$search%'
        ) OR MATCH(fname, mname, lname, username) AGAINST ('*$search*' IN BOOLEAN MODE)
      ", NULL, FALSE);
    }

    $this->db
      ->order_by('updated_at')
      ->order_by('created_at');

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($user) {
    return $this->_create('users', $user);
  }

  public function insertMultiple($users) {
    return $this->db->insert_batch('users', $users);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('users');
  }
}

?>
