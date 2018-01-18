<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Fields_model extends MY_CRUD_Model {

  public function getFieldsByCourseId($id) {
    $query = $this->db
      ->select('field_id')
      ->from('course_field_relation')
      ->where('course_id', $id)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getFieldsByBookIds($books) {
    if (!$books) {
      return FALSE;
    }

    $query = $this->db
      ->select('field_id')
      ->distinct()
      ->from('book_field_relation')
      ->where_in('book_id', $books)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getOutcomesByTopicIds($topics, $type) {
    if (!$topics) {
      return FALSE;
    }

    $query = $this->db
      ->select('o.id AS outcome_id')
      ->distinct()
      ->from('topic_outcome_relation tor')
      ->join('outcomes o', 'o.id = tor.outcome_id')
      ->where('o.type', $type)
      ->where_in('tor.topic_id', $topics)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getMaterialsByTopicIds($topics) {
    if (!$topics) {
      return FALSE;
    }

    $query = $this->db
      ->select('m.id AS material_id')
      ->distinct()
      ->from('topic_material_relation tmr')
      ->join('materials m', 'm.id = tmr.material_id')
      ->where_in('tmr.topic_id', $topics)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getTasksByTopicIds($topics) {
    if (!$topics) {
      return FALSE;
    }

    $query = $this->db
      ->select('t.id AS task_id')
      ->distinct()
      ->from('topic_task_relation ttr')
      ->join('tasks t', 't.id = ttr.task_id')
      ->where_in('ttr.topic_id', $topics)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
