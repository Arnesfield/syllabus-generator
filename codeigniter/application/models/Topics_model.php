<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics_model extends MY_Custom_Model {

  public function getWhereInName($topics = FALSE) {
    if (!$topics) {
      return array();
    }
    
    $query = $this->db
      ->from('topics')
      ->where_in('name', $topics)
      ->where('status !=', -1)
      ->get();
    return $this->_res($query);
  }

  public function getByQuery($search = FALSE, $where = FALSE) {
    $this->db
      ->from('topics')
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
    
    if ($where) {
      $this->db->where($where);
    }
    
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
      ->where('status !=', -1)
      ->where("
        (
          (
            LOWER(tags) LIKE '%$t%'
          ) OR MATCH(tags) AGAINST ('*$t*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->limit($limit);

    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
