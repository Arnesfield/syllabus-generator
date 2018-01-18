<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tasks_model extends MY_CRUD_Model {

  public function getByQuery($search) {
    $this->db
      ->select('id, name')
      ->from('tasks')
      ->where("lower(name) like lower(concat('%', '$search', '%'))");
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
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
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
