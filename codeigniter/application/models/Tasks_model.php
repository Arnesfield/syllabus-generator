<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tasks_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE) {
    $this->db
      ->from('tasks')
      ->where('status !=', -1);

    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          (
            LOWER(name) LIKE '%$search%' OR
            LOWER(tags) LIKE '%$search%'
          ) OR MATCH(name, tags) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getByTags($tags = FALSE, $limit = 10) {
    if (!$tags) {
      return array();
    }

    // concatenate tags
    $t = implode(' ', $tags);
    $t = strtolower($t);

    $query = $this->db
      ->from('tasks')
      ->where("
        (
          (
            LOWER(tags) LIKE '%$t%'
          ) OR MATCH(tags) AGAINST ('*$t*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->limit($limit)
      ->get();

    return $this->_res($query);
  }

  public function getRelatedTasksWithFields($fields, $limit = 10, $tasks = FALSE) {
    if (!$fields) {
      return FALSE;
    }
    
    $this->db
      ->select('
        t.id AS id,
        t.name AS name
      ')
      ->from('task_field_relation tfr')
      ->join('tasks t', 't.id = tfr.task_id')
      ->join('fields f', 'f.id = tfr.field_id')
      ->where_in('f.id', $fields);
    
    if ($tasks) {
      $this->db->where_in('t.id', $tasks);
    }

    $this->db
      ->group_by('t.id')
      ->order_by('COUNT(*)', 'DESC')
      ->limit($limit);
    
    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
