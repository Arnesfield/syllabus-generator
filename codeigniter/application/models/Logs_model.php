<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logs_model extends MY_Custom_Model {

  public function get($where = FALSE) {
    $this->db
      ->select('
        au.*,
        u.id AS user_id,
        u.fname AS fname,
        u.mname AS mname,
        u.lname AS lname,
        u.username AS username,
        u.title AS title,
        u.img_src AS img_src
      ')
      ->from('audit_trail au')
      ->join('users u', 'u.id = au.user_id')
      ->where(array(
        'au.status !=' => -1,
        'u.status !=' => 0,
        'u.status !=' => -1
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db->order_by('au.created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getWorkflow($where = FALSE) {
    $this->db
      ->select('
        au.*,
        u.id AS user_id,
        u.fname AS fname,
        u.mname AS mname,
        u.lname AS lname,
        u.username AS username,
        u.title AS title,
        u.img_src AS img_src
      ')
      ->from('audit_trail au')
      ->join('users u', 'u.id = au.user_id')
      ->where(array(
        // workflow category # is 2
        'au.category' => 2,
        'au.status !=' => -1,
        'u.status !=' => 0,
        'u.status !=' => -1
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db->order_by('au.created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function getUserLogs($where = FALSE) {
    $this->db
      ->select('
        au.*,
        u.id AS user_id,
        u.fname AS fname,
        u.mname AS mname,
        u.lname AS lname,
        u.username AS username,
        u.title AS title,
        u.img_src AS img_src
      ')
      ->from('audit_trail au')
      ->join('users u', 'u.id = au.user_id')
      ->where(array(
        // user log # is 1
        'au.category' => 1,
        'au.status !=' => -1,
        'u.status !=' => 0,
        'u.status !=' => -1
      ));

    if ($where) {
      $this->db->where($where);
    }

    $this->db->order_by('au.created_at', 'DESC');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insertTrail($data) {
    return $this->db->insert('audit_trail', $data);
  }

  public function insertUserLog($data) {
    $data['category'] = 1;
    return $this->db->insert('audit_trail', $data);
  }
  
  public function insertWorkflow($data) {
    $data['category'] = 2;
    return $this->db->insert('audit_trail', $data);
  }
}

?>
