<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  private $courses = 'courses';

  public function getByQuery($search) {
    $this->db->from($this->courses)->where(
      "lower(concat(IFNULL(title, ''), IFNULL(code, ''))) like lower(concat('%', '$search', '%'))"
    );
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>