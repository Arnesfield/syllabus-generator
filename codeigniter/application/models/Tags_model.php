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
}

?>
