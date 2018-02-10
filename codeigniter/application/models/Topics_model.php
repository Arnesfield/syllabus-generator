<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics_model extends MY_Custom_Model {

  public function getByQuery($search) {
    $this->db
      ->select('
        t.id AS id,
        t.label AS label,
        t.name AS name,
        t.description AS description
      ')
      ->from('topic_field_relation tfr')
      ->join('topics t', 't.id = tfr.topic_id')
      ->join('fields f', 'f.id = tfr.field_id')
      ->where("
        lower(concat(
          IFNULL(f.title, ''),
          IFNULL(t.label, ''), IFNULL(t.name, ''), IFNULL(t.description, '')
        ))
        like lower(concat('%', '$search', '%'))
      ")
      ->group_by('t.id');
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getRelatedTopicsWithFieldsAndOutcomes($fields, $outcomes, $limit = 10) {
    if (!$fields) {
      return FALSE;
    }

    $this->db
      ->select('
        t.id AS id,
        t.label AS label,
        t.name AS name,
        t.description AS description
      ')
      ->from('topic_field_relation tfr')
      ->join('topic_outcome_relation tor', 'tfr.topic_id = tor.topic_id')
      ->join('topics t', 't.id = tfr.topic_id')
      ->join('fields f', 'f.id = tfr.field_id')
      ->join('outcomes o', 'o.id = tor.outcome_id')
      ->where_in('f.id', $fields);
    
    if ($outcomes) {
      $this->db->where("MATCH(o.content) AGAINST('$outcomes')", NULL, FALSE);
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
