<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE, $where = FALSE) {
    $this->db
      ->from('courses')
      ->where('status !=', -1);

    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          (
            LOWER(code) LIKE '%$search%' OR
            LOWER(title) LIKE '%$search%' OR
            LOWER(tags) LIKE '%$search%'
          ) OR MATCH(code, title, tags) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    if ($where) {
      $this->db->where($where);
    }

    $this->db
      ->order_by('updated_at')
      ->order_by('created_at');

    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function getWhere($where) {
    $this->db
      ->from('courses')
      ->where('status !=', -1)
      ->where($where)
      ->order_by('updated_at')
      ->order_by('created_at');
    
    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function getWhereIdIn($ids) {
    $this->db
      ->from('courses')
      ->where('status !=', -1)
      ->where_in('id', $ids)
      ->order_by('title')
      ->order_by('code');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($course) {
    return $this->_create('courses', $course);
  }

  public function insertMultiple($courses) {
    return $this->db->insert_batch('courses', $courses);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('courses');
  }
}

?>