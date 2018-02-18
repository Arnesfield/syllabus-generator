<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi_model extends MY_Custom_Model {
  public function getByCourseId($cid) {
    $query = $this->db
      ->from('syllabi')
      ->where('course_id', $cid)
      ->where('version !=', '')
      ->order_by("CONCAT(
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 1), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 2), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 3), '.', -1), 10, '0') 
       )", 'DESC', FALSE)
      ->limit(5)
      ->get();
    return $this->_res($query);
  }

  public function getByAssignId($id) {
    $this->db
      ->from('syllabi')
      ->where('assign_id', $id);

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