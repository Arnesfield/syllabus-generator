<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  private $curriculum = 'curriculum';

  public function get() {
    $query = $this->db
      ->from($this->curriculum)
      ->order_by('label', 'ASC')
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>