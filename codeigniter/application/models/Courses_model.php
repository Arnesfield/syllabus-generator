<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses_model extends MY_CRUD_Model {

  public function getByQuery($search = FALSE) {
    $this->db->from('courses');

    if ($search) {
      $this->db->where("lower(concat(IFNULL(title, ''), IFNULL(code, ''))) like lower(concat('%', '$search', '%'))");
    }

    $query = $this->db->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }
  
  public function getRelatedCoursesById($id, $type) {
    $query = $this->db
      ->select()
      ->from('course_relation cr')
      ->join('courses c', 'c.id = cr.course_id')
      ->join('courses r', 'r.id = cr.related_course_id')
      ->where('c.id', $id)
      ->where('cr.type', $type)
      ->get();
    return $query->num_rows() > 0 ? $query->result_array() : FALSE;
  }

  public function insert($course) {
    return $this->_create('courses', $course);
  }

  public function insertMultiple($courses) {
    return $this->db->insert_batch('courses', $courses);
  }
}

?>