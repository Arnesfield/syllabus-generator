<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE, $where = FALSE, $limit = FALSE) {
    $this->db
      ->from('curriculum')
      ->where('status !=', -1);

    if ($search) {
      $search = strtolower($search);
      $this->db->like('LOWER(label)', $search);
    }

    if ($where) {
      $this->db->where($where);
    }

    $this->db
      ->order_by('label', 'DESC')
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC');

    if ($limit !== FALSE) {
      $this->db->limit($limit);
    }
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getLatest() {
    $this->db
      ->from('curriculum')
      ->where('status', 1)
      ->order_by('latest', 'DESC')
      ->order_by('label', 'DESC')
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC')
      ->limit(1);
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($data) {
    return $this->db->insert('curriculum', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('curriculum');
  }

  /* public function getYearsByQuery($search = NULL, $limit = NULL) {
    $this->db
      ->distinct()
      ->select('year')
      ->from($this->curriculum)
      ->where('status !=', -1);

    if ($search) {
      $this->db->like('year', $search);
    }

    $this->db->order_by('year', 'DESC');

    if (is_numeric($limit)) {
      $this->db->limit($limit);
    }
      
    $query = $this->db->get();
    return $this->_res($query);
  } */
}

?>
