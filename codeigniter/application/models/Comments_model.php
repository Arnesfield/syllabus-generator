<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Comments_model extends MY_Custom_Model {

  public function get($assignId = NULL) {
    $this->db->from('comments');

    if ($assignId) {
      $this->db->where('assign_id', $assignId);
    }

    $this->db
      ->where('status !=', -1)
      ->order_by('created_at', 'DESC');
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($data) {
    return $this->db->insert('comments', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('comments');
  }

  public function getUsersByIds($ids) {
    if (!$ids) {
      return array();
    }

    $this->db
      ->from('users')
      ->where_in('id', $ids);
    
    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
