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

  public function getByQuery($search = FALSE, $where = FALSE, $auth = FALSE, $limit = FALSE) {
    
    $this->db
      ->from('users')
      ->where('status !=', -1);
    
    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          (
            LOWER(fname) LIKE '%$search%' OR
            LOWER(mname) LIKE '%$search%' OR
            LOWER(lname) LIKE '%$search%' OR
            LOWER(username) LIKE '%$search%' OR
            LOWER(title) LIKE '%$search%'
          ) OR MATCH(fname, mname, lname, username, title) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    if ($where) {
      $this->db->where($where);
    }

    if (is_array($auth)) {
      // loop through auth
      $str = '(';
      foreach ($auth as $key => $value) {
        // concat a like
        $str .= "auth LIKE '%\"$value\"%' OR";
      }
      $str .= ' 0)';
      $this->db->where($str, NULL, FALSE);
    }

    $this->db
      ->order_by('updated_at')
      ->order_by('created_at');

    if ($limit !== FALSE) {
      $this->db->limit($limit);
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

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('users');
  }
}

?>
