<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi_model extends MY_Custom_Model {
  public function getByQuery($search = FALSE, $where = FALSE) {
    $this->db
      ->from('syllabi')
      // ->where('course_id', $cid)
      // ->where('version !=', '')
      ->where('status !=', -1);

    if ($where) {
      $this->db->where($where);
    }

    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        LOWER(CONCAT(IFNULL(version, '')))
        LIKE '%$search%'
      ");
    }

    $this->db
      ->order_by("CONCAT(
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 1), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 2), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 3), '.', -1), 10, '0') 
        )", 'DESC', FALSE)
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getLatest($where = FALSE) {
    $this->db
      ->from('syllabi')
      ->where(array(
        'status !=' => -1,
        'version !=' => ''
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db
      ->order_by("CONCAT(
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 1), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 2), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 3), '.', -1), 10, '0') 
        )", 'DESC', FALSE)
      ->order_by('updated_at', 'DESC')
      ->order_by('created_at', 'DESC')
      ->limit(1);
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getByAssignId($id) {
    $this->db
      ->from('syllabi')
      ->where('assign_id', $id)
      ->where('status !=', -1);

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($data) {
    return $this->db->insert('syllabi', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('syllabi');
  }
}

?>