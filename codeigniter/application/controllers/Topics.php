<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('topics_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $search = $this->_filter($this->input->post('search'));
    $topics = $this->topics_model->getByQuery($search);
    $topics = $this->topics_model->_to_col($topics, 'name');
    $this->_json(TRUE, 'topics', $topics);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $books = $this->input->post('books') ? $this->input->post('books') : FALSE;
    $outcomes = $this->_filter($this->input->post('outcomes'));
    $curriculum_id = $this->input->post('curriculumId');
    $limit = $this->input->post('limit');

    $tags = array();

    // get tags of course and books
    $tags = $this->_g_getTagsOfCourse($course_id, $tags);
    $tags = $this->_g_getTagsOfBooks($books, $tags);

    // unique tags
    $tags = array_unique($tags);

    // get topics
    // iclude both clo and ilo content
    $topics = $this->topics_model->getRelatedTopicsWithFieldsAndOutcomes($tags, $outcomes, $limit);
    $topics = $this->topics_model->_to_col($topics, 'name');
    $this->_json(TRUE, 'topics', $topics);
  }
}

?>
