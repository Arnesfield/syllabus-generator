<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logs_model extends MY_Custom_Model {
  public function getWorkflow($where = FALSE) {
    $this->db
      ->select('
        w.*,
        u.id AS user_id,
        u.fname AS fname,
        u.mname AS mname,
        u.lname AS lname,
        u.username AS username,
        u.title AS title,
        u.img_src AS img_src
      ')
      ->from('workflow_logs w')
      ->join('users u', 'u.id = w.user_id')
      ->where(array(
        'w.status !=' => -1,
        'u.status !=' => 0,
        'u.status !=' => -1
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db->order_by('w.created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getUserLogs($where = FALSE) {
    $this->db
      ->select('
        ul.*,
        u.id AS user_id,
        u.fname AS fname,
        u.mname AS mname,
        u.lname AS lname,
        u.username AS username,
        u.title AS title,
        u.img_src AS img_src
      ')
      ->from('user_logs ul')
      ->join('users u', 'u.id = ul.user_id')
      ->where(array(
        'ul.status !=' => -1,
        'u.status !=' => 0,
        'u.status !=' => -1
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db->order_by('ul.created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insertUserLog($data) {
    return $this->db->insert('user_logs', $data);
  }

  public function insertWorkflow($data) {
    return $this->db->insert('workflow_logs', $data);
  }
}

?>
