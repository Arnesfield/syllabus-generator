<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum_model extends MY_Custom_Model {

  private $curriculum = 'curriculum';

  public function get($year = NULL) {
    $this->db
      ->select('id, label, content, year')
      ->from($this->curriculum);

    if ($year) {
      $this->db->where('year', $year);
    }

    $this->db
      ->where('status', 1)
      ->order_by('label', 'ASC')
      ->order_by('year', 'DESC');
      
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getYearsByQuery($search = NULL, $limit = NULL) {
    $this->db
      ->distinct()
      ->select('year')
      ->from($this->curriculum)
      ->where('status', 1);

    if ($search) {
      $this->db->like('year', $search);
    }

    $this->db->order_by('year', 'DESC');

    if (is_numeric($limit)) {
      $this->db->limit($limit);
    }
      
    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>