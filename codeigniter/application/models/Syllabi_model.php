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
      ->order_by("CONCAT(
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 1), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 2), '.', -1), 10, '0'),
        LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(version, '.', 3), '.', -1), 10, '0') 
       )", 'DESC', FALSE)
      ->limit(5)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>