<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE, $where = FALSE) {
    $this->db
      ->from('books')
      ->where('status !=', -1);

    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          (
            LOWER(citation) LIKE '%$search%' OR
            LOWER(tags) LIKE '%$search%'
          ) OR MATCH(citation, tags) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    if ($where) {
      $this->db->where($where);
    }

    $this->db
      ->order_by('citation')
      ->order_by('updated_at')
      ->order_by('created_at');

    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function get() {
    $this->db
      ->from('books')
      ->where('status !=', -1)
      ->order_by('updated_at')
      ->order_by('created_at');
    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function getWhereInCitation($books = FALSE) {
    if (!$books) {
      return array();
    }

    $query = $this->db
      ->from('books')
      ->where_in('citation', $books)
      ->where('status !=', -1)
      ->order_by('updated_at')
      ->order_by('created_at')
      ->get();
    return $this->_res($query);
  }

  public function getRelatedBooksWithFields($fields, $limit = 10) {
    if (!$fields) {
      return FALSE;
    }

    // concatenate fields
    $tags = implode(' ', $fields);
    $tags = strtolower($tags);

    $query = $this->db
      ->from('books')
      ->where("
        (
          (
            LOWER(tags) LIKE '%$tags%'
          ) OR MATCH(tags) AGAINST ('*$tags*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->where('status !=', -1)
      ->order_by('updated_at')
      ->order_by('created_at')
      ->limit($limit)
      ->get();
    return $this->_res($query);
  }

  public function insert($book) {
    return $this->_create('books', $book);
  }

  public function insertMultiple($books) {
    return $this->db->insert_batch('books', $books);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('books');
  }
}

?>
