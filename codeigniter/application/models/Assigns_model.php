<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Assigns_model extends MY_Custom_Model {

  public function get($id = NULL) {
    $this->db
      ->select('id, content, created_at, updated_at, status')
      ->from('assigns');

    if ($id) {
      $this->db->where('id', $id);
    }

    $this->db
      ->where('status !=', -1)
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC');
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getUsersWithIds($ids) {
    $this->db
      ->select('*')
      ->from('users');

    if ($ids) {
      $this->db->where_in('id', $ids);
    }

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getCoursesWithIds($ids) {
    $this->db
      ->select('*')
      ->from('courses');

    if ($ids) {
      $this->db->where_in('id', $ids);
    }

    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
