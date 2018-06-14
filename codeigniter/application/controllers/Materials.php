<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Materials extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('materials_model');
  }
  
  public function index() {
    $search = $this->_filter($this->input->post('search'));
    $materials = $this->materials_model->getByQuery($search);
    $materials = $this->materials_model->_to_col($materials, 'name');
    $this->_json(TRUE, 'materials', $materials);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $books = $this->input->post('books') ? $this->input->post('books') : FALSE;
    $topics = $this->input->post('topics') ? $this->input->post('topics') : FALSE;
    $curriculum_id = $this->input->post('curriculumId');
    $limit = $this->input->post('limit');

    $tags = array();

    // get tags of course, books, and topics
    $tags = $this->_g_getTagsOfCourse($course_id, $tags);
    $tags = $this->_g_getTagsOfBooks($books, $tags);
    $tags = $this->_g_getTagsOfTopics($topics, $tags);

    // unique tags
    $tags = array_unique($tags);

    // get materials
    $materials = $this->materials_model->getByTags($tags, $limit);
    $materials = $this->materials_model->_to_col($materials, 'name');
    $this->_json(TRUE, 'materials', $materials);
  }
}

?>
