<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes_model extends MY_Custom_Model {

  public function getByQuery($search, $where, $limit = NULL) {
    $this->db->from('outcomes');

    if ($where) {
      $this->db->where($where);
    }

    if ($search) {
      $search = strtolower($search);
      $this->db->where("
        (
          (
            LOWER(content) LIKE '%$search%' OR
            LOWER(tags) LIKE '%$search%'
          ) OR MATCH(content, tags) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    if (is_numeric($limit)) {
      $this->db->limit($limit);
    }
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getByTags($type, $tags = FALSE, $limit = 10) {
    if (!$tags) {
      return array();
    }

    // concatenate tags
    $t = implode(' ', $tags);
    $t = strtolower($t);

    $query = $this->db
      ->from('outcomes')
      ->where("
        (
          (
            LOWER(tags) LIKE '%$t%'
          ) OR MATCH(tags) AGAINST ('*$t*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->where('type', $type)
      ->limit($limit)
      ->get();

    return $this->_res($query);
  }

  public function getRelatedOutcomesWithFields($fields, $type, $limit = 10, $outcomes = FALSE) {
    if (!$fields) {
      return array();
    }
    
    $this->db
      ->select('
        o.id AS id,
        o.content AS content
      ')
      ->from('outcome_field_relation ofr')
      ->join('outcomes o', 'o.id = ofr.outcome_id')
      ->join('fields f', 'f.id = ofr.field_id')
      ->where('o.type', $type)
      ->where_in('f.id', $fields);
    
    if ($outcomes) {
      $this->db->where_in('o.id', $outcomes);
    }

    $this->db
      ->group_by('o.id')
      ->order_by('COUNT(*)', 'DESC')
      ->limit($limit);
      
    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function getILOsFromCLOs($clo_content = FALSE, $limit = 10) {
    if (!$clo_content) {
      return array();
    }

    $this->db
      ->select('ilo.id AS outcome_id')
      ->from('outcome_relation r')
      ->join('outcomes clo', 'clo.id = r.clo_id')
      ->join('outcomes ilo', 'ilo.id = r.ilo_id')
      ->where('clo.type', 1)
      ->where('ilo.type', 2)
      ->where("MATCH(clo.content) AGAINST('$clo_content')", NULL, FALSE)
      ->group_by('ilo.id')
      ->order_by('COUNT(*)', 'DESC')
      ->limit($limit);

    $query = $this->db->get();
    return $this->_res($query);
  }
}

?>
