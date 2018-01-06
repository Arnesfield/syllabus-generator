<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes_model extends MY_CRUD_Model {

  public function getByQuery($type, $search) {
    $this->db
      ->select('id, content')
      ->from('outcomes')
      ->where('type', $type)
      ->where("lower(content) like lower(concat('%', '$search', '%'))");
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getRelatedOutcomesWithFields($fields, $type, $limit = 10) {
    if (!$fields) {
      return FALSE;
    }

    $query = $this->db
      ->select('
        o.id AS id,
        o.content AS content
      ')
      ->from('outcome_field_relation ofr')
      ->join('outcomes o', 'o.id = ofr.outcome_id')
      ->join('fields f', 'f.id = ofr.field_id')
      ->where('o.type', $type)
      ->where_in('f.id', $fields)
      ->order_by('COUNT(*)', 'DESC')
      ->group_by('o.id')
      ->limit($limit)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
