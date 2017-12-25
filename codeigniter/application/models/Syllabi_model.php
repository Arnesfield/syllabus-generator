<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  private $syllabi = 'syllabi';

  public function getByCourseId($cid) {
    $query = $this->db
      ->from($this->syllabi)
      ->where('course_id', $cid)
      ->order_by('updated_at', 'DESC')
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>