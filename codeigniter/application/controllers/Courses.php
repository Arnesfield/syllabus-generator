<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('courses_model');
  }
  
  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : '';
    $courses = $this->courses_model->getByQuery($search);
    $this->_json('courses', $courses);
  }

  public function related() {
    $id = $this->input->post('id');

    // prereq type 1
    // coreq type 2

    $prerequisites = $this->courses_model->getRelatedCoursesById($id, 1);
    $corequisites = $this->courses_model->getRelatedCoursesById($id, 2);
    $this->_json(array(
      'prerequisites' => $prerequisites,
      'corequisites' => $corequisites
    ));
  }

  public function add() {
    $post_values = array('title', 'code', 'description', 'objectives', 'unitsLec', 'unitsLab', 'status');
    foreach ($post_values as $value) {
      $course[$value] = $this->_filter($this->input->post($value));
    }
    $res = $this->courses_model->insert($course);
    $this->_json('success', $res);
  }

  public function addCsv() {
    $courses = $this->input->post('courses');
    $res = $this->courses_model->insertMultiple($courses);
    $this->_json('success', $res);
  }
}

?>
