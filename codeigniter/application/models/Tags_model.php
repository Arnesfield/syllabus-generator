<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tags_model extends MY_Custom_Model {
  public function getByQuery($search = FALSE) {
    $this->db
      ->from('fields')
      ->where('status', 1);
    
    if ($search) {
      $search = strtolower($search);
      $this->db->like('LOWER(title)', $search);
    }

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insertMultiple($data) {
    if (!$data) {
      return TRUE;
    }

    // get fields
    $q = $this->db
      ->from('fields')
      ->where_in('title', $data)
      ->where('status', 1)
      ->get();
    
    $fields = $this->_res($q);
    $in_db_fields = $this->_to_col($fields, 'title');

    // remove fields in $data that are in db
    $filtered = $this->_remove_existing($data, $in_db_fields);

    // do not continue if there is nothing new
    if (!$filtered) {
      return TRUE;
    }

    // assert that filtered does not exist in db
    // add these to array
    // turn fields to array
    $to_add = array();
    foreach ($filtered as $key => $value) {
      array_push($to_add, array(
        'title' => $value,
        'status' => 1
      ));
    }
    
    return $this->db->insert_batch('fields', $to_add);
  }
}

?>
