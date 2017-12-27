<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics_model extends MY_CRUD_Model {

  public function __construct() {
    parent::__construct();
  }

  public function getByQuery($search) {
    $this->db
      ->select('
        b.id AS b_id,
        b.citation AS b_citation,
        b.status AS b_status
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

  public function getFields() {
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
      ->order_by('b.id', 'ASC');
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getFieldsByCourseId($id) {
    $query = $this->db
      ->select('field_id')
      ->from('course_field_relation')
      ->where('course_id', $id)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getRelatedBooksToCourseId($id, $limit = 10) {
    $fields = $this->getFieldsByCourseId($id);
    if (!$fields) {
      return FALSE;
    }

    foreach ($fields as $key => $field) {
      $fields[$key] = $field['field_id'];
    }

    $query = $this->db
      ->select('
        b.id AS b_id,
        b.citation AS b_citation,
        b.status AS b_status
      ')
      ->from('book_field_relation bfr')
      ->join('books b', 'b.id = bfr.book_id')
      ->where_in('bfr.field_id', $fields)
      ->order_by('COUNT(*)', 'DESC')
      ->group_by('b.id')
      ->limit($limit)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
