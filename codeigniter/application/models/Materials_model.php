<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Materials_model extends MY_CRUD_Model {

  public function getByQuery($search) {
    $this->db
      ->select('id, name')
      ->from('materials')
      ->where("lower(name) like lower(concat('%', '$search', '%'))");
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function getRelatedMaterialsWithFields($fields, $limit = 10, $materials = FALSE) {
    if (!$fields) {
      return FALSE;
    }
    
    $this->db
      ->select('
        m.id AS id,
        m.name AS name
      ')
      ->from('material_field_relation mfr')
      ->join('materials m', 'm.id = mfr.material_id')
      ->join('fields f', 'f.id = mfr.field_id')
      ->where_in('f.id', $fields);
    
    if ($materials) {
      $this->db->where_in('m.id', $materials);
    }

    $this->db
      ->group_by('m.id')
      ->order_by('COUNT(*)', 'DESC')
      ->limit($limit);
      
    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
}

?>
