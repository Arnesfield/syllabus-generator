<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes_model extends MY_Custom_Model {

  public function getByQuery($search, $where, $limit = NULL, $detailed = FALSE) {
    $detailed_content = '';
    
    if ($detailed) {
      $detailed_content = "
        CONCAT(content, ' ',
          CASE
            WHEN (type = 1) THEN 'Course Learning Outcomes (CLO)'
            WHEN (type = 2) THEN 'Intended Learning Ouctomes (ILO)'
            WHEN (type = 3) THEN 'Faculty: Teaching and Learning Activities (TLA)'
            WHEN (type = 4) THEN 'Student: Teaching and Learning Activities (TLA)'
          END
        )
      ";
    }

    $this->db
      ->from('outcomes')
      ->where('status !=', -1);

    if ($where) {
      $this->db->where($where);
    }

    if ($search) {
      $search = strtolower($search);
      $content = $detailed_content ? $detailed_content : 'content';

      $this->db->where("
        (
          (
            LOWER($content) LIKE '%$search%' OR
            LOWER(tags) LIKE '%$search%'
          ) OR MATCH(content, tags) AGAINST ('*$search*' IN BOOLEAN MODE)
        )
      ", NULL, FALSE);
    }

    if (is_numeric($limit)) {
      $this->db->limit($limit);
    }
    
    $this->db
      ->order_by('content')
      ->order_by('updated_at')
      ->order_by('created_at');

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
      ->where('status !=', -1)
      ->where('status !=', 0)
      ->limit($limit)
      ->get();

    return $this->_res($query);
  }

  public function insert($data) {
    return $this->db->insert('outcomes', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('outcomes');
  }
}

?>
