<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  public function getByQuery($search) {
    $this->db
      ->select('
        bfr.id AS id,
        b.id AS b_id,
        f.id AS f_id,
        b.citation AS b_citation,
        b.status AS b_status,
        f.title AS f_title,
        f.description AS f_description,
        f.status AS f_status
      ')
      ->from('book_field_relation bfr')
      ->join('books b', 'b.id = bfr.book_id')
      ->join('fields f', 'f.id = bfr.field_id')
      ->where("
        lower(concat(IFNULL(f.title, ''), IFNULL(b.citation, '')))
        like lower(concat('%', '$search', '%'))
      ")
      ->group_by('b_id');
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getFieldsByQuery($search) {
    $this->db
      ->select('
        f.id AS id,
        b.id AS b_id,
        f.title AS title,
        f.status AS status
      ')
      ->from('book_field_relation bfr')
      ->join('books b', 'b.id = bfr.book_id')
      ->join('fields f', 'f.id = bfr.field_id')
      ->where("
        lower(concat(IFNULL(f.title, ''), IFNULL(b.citation, '')))
        like lower(concat('%', '$search', '%'))
      ")
      ->order_by('b.id', 'ASC');
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
