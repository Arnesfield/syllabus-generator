<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books_model extends MY_CRUD_Model {

  public function getByQuery($search = FALSE) {
    $this->db
      ->select('
        b.id AS id,
        b.citation AS citation,
        b.status AS status
      ')
      ->from('book_field_relation bfr')
      ->join('books b', 'b.id = bfr.book_id')
      ->join('fields f', 'f.id = bfr.field_id');
    
    if ($search) {
      $this->db->where("
        lower(concat(IFNULL(f.title, ''), IFNULL(b.citation, '')))
        like lower(concat('%', '$search', '%'))
      ");
    }

    $this->db->group_by('id');

    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getRelatedBooksWithFields($fields, $limit = 10) {
    if (!$fields) {
      return FALSE;
    }

    $query = $this->db
      ->select('
        b.id AS id,
        b.citation AS citation,
        b.status AS status
      ')
      ->from('book_field_relation bfr')
      ->join('books b', 'b.id = bfr.book_id')
      ->join('fields f', 'f.id = bfr.field_id')
      ->where_in('bfr.field_id', $fields)
      ->group_by('b.id')
      ->order_by('COUNT(*)', 'DESC')
      ->limit($limit)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
