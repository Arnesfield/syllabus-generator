<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Materials_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE) {
    $this->db
      ->from('materials')
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

    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getByTags($tags = FALSE, $limit = 10) {
    if (!$tags) {
      return array();
    }

    // concatenate tags
    $t = implode(' ', $tags);
    $t = strtolower($t);

    $query = $this->db
      ->from('materials')
      ->where("
        (
          (
            LOWER(tags) LIKE '%$t%'
          ) OR MATCH(tags) AGAINST ('*$t*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE)
      ->limit($limit)
      ->get();

    return $this->_res($query);
  }
}

?>
