<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  private $curriculum = 'curriculum';

  public function get($year = NULL) {
    $this->db
      ->select('id, label, content')
      ->from($this->curriculum);

    if ($year) {
      $this->db->where('year', $year);
    }

    $this->db
      ->where('status', 1)
      ->order_by('label', 'ASC')
      ->order_by('year', 'DESC');
      
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getYearsByQuery($search = NULL) {
    $this->db
      ->distinct()
      ->select('year')
      ->from($this->curriculum)
      ->where('status', 1);

    if ($search) {
      $this->db->like('year', $search);
    }

    $this->db->order_by('year', 'DESC');
      
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>