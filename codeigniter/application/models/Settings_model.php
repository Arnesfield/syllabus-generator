<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings_model extends MY_Custom_Model {
  public function get($where) {
    $query = $this->db
      ->from('settings')
      ->where($where)
      ->get();
    return $this->_res($query);
  }

  public function insert($data) {
    return $this->db->insert('settings', $data);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('settings');
  }
}

?>
