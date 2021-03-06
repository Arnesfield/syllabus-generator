<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Assigns_model extends MY_Custom_Model {

  public function get($id = NULL) {
    $this->db->from('assigns');

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

  public function getAssigned($id = NULL) {
    $this->db->from('assigns');

    if ($id) {
      $this->db
        ->like('content', '"assigned":'.$id)
        ->or_like('content', '"assigned":"'.$id.'"');
    }

    $this->db
      ->where('status !=', -1)
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC');
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getMyAssigns($id = NULL) {
    $this->db->from('assigns');

    if ($id) {
      $this->db
        ->where("
        (
          content LIKE '%\"assigned\":{\"id\":$id%' OR
          content LIKE '%\"assigned\":{\"id\":\"$id\"%'
        )
        ", NULL, FALSE);
    }

    $this->db
      ->where('status !=', -1)
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC');
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getMyReviews($id = NULL) {
    $this->db->from('assigns');

    if ($id) {
      $this->db
        ->where("
        (
          content LIKE '%\"levels\"%\"id\":$id%' OR
          content LIKE '%\"levels\"%\"id\":\"$id\"%'
        )
        ", NULL, FALSE);
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

  public function insert($data) {
    return $this->db->insert('assigns', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('assigns');
  }
}

?>
