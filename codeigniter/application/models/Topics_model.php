<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics_model extends MY_Custom_Model {

  public function getByQuery($search) {
    $this->db
      ->select('
        t.id AS id,
        t.name AS name
      ')
      ->from('topic_field_relation tfr')
      ->join('topics t', 't.id = tfr.topic_id')
      ->join('fields f', 'f.id = tfr.field_id')
      ->where("
        lower(concat(
          IFNULL(f.title, ''), IFNULL(t.name, '')
        ))
        like lower(concat('%', '$search', '%'))
      ")
      ->group_by('t.id');
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getRelatedTopicsWithFieldsAndOutcomes($tags, $outcomes, $limit = 10) {
    if (!$tags) {
      return FALSE;
    }

    // concatenate tags
    $t = implode(' ', $tags);
    $t = strtolower($t);

    $this->db
      ->from('topics')
      ->where("
        (
          (
            LOWER(tags) LIKE '%$t%'
          ) OR MATCH(tags) AGAINST ('*$t*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->limit($limit);

    /* $this->db
      ->select('
        t.id AS id,
        t.name AS name
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
      ->limit($limit); */

    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
