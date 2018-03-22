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
      $this->db->or_where("
        lower(concat(
          IFNULL(fname, ''),
          ' ',
          IFNULL(mname, ''),
          ' ',
          IFNULL(lname, '')
        ))
        like lower(concat('%', '$search', '%'))
      ");
      $this->db->or_where("
        lower(concat(
          IFNULL(fname, ''),
          ' ',
          IFNULL(lname, '')
        ))
        like lower(concat('%', '$search', '%'))
      ");
      $this->db->or_where("
        lower(concat(IFNULL(username, '')))
        like lower(concat('%', '$search', '%'))
      ");
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
