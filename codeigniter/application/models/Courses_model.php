<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses_model extends MY_Custom_Model {

  public function getByQuery($search = FALSE) {
    $this->db
      ->from('courses')
      ->where('status !=', -1);

    if ($search) {
      $this->db->where("lower(concat(IFNULL(title, ''), IFNULL(code, ''))) like lower(concat('%', '$search', '%'))");
    }

    $this->db
      ->order_by('updated_at')
      ->order_by('created_at');

    $query = $this->db->get();
    return $this->_res($query);
  }
  
  public function getRelatedCoursesById($id, $type) {
    $query = $this->db
      ->select()
      ->from('course_relation cr')
      ->join('courses c', 'c.id = cr.course_id')
      ->join('courses r', 'r.id = cr.related_course_id')
      ->where(array(
        'c.id' => $id,
        'cr.type' => $type,
        'c.status !=' => -1,
        'r.status !=' => -1
      ))
      ->get();
    return $this->_res($query);
  }
  
  public function getWhere($where) {
    $this->db
      ->from('courses')
      ->where('status !=', -1)
      ->where($where)
      ->order_by('updated_at')
      ->order_by('created_at');
    
    $query = $this->db->get();
    return $this->_res($query);
  }

  public function insert($course) {
    return $this->_create('courses', $course);
  }

  public function insertMultiple($courses) {
    return $this->db->insert_batch('courses', $courses);
  }

  public function update($data, $where) {
    return $this->db
      ->set($data)
      ->where($where)
      ->update('courses');
  }
}

?>