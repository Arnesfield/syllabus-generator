<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('outcomes_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $type = $this->input->post('type') ? $this->input->post('type') : FALSE;
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : FALSE;

    $where = array();
    if ($type) {
      $where['type'] = $type;
    }
    
    $outcomes = $this->outcomes_model->getByQuery($search, $where);

    // change outcomes to string
    if ($outcomes) {
      foreach ($outcomes as $key => $outcome) {
        $outcomes[$key] = $outcome['content'];
      }
    }

    $this->_json(TRUE, 'outcomes', $outcomes);
  }

  public function suggest() {
    $type = $this->input->post('type');
    $course_id = $this->input->post('courseId');
    $books = $this->input->post('books') ? $this->input->post('books') : FALSE;
    $topics = $this->input->post('topics') ? $this->input->post('topics') : FALSE;
    $limit = $this->input->post('limit');

    // type 1 = clo
    // type 2 = ilo
    // type 3 = tla faculty
    // type 4 = tla student

    $tags = array();

    // get tags of course, books, and topics
    $tags = $this->_g_getTagsOfCourse($course_id, $tags);
    $tags = $this->_g_getTagsOfBooks($books, $tags);
    $tags = $this->_g_getTagsOfTopics($topics, $tags);

    // unique tags
    $tags = array_unique($tags);

    // get outcomes
    $outcomes = $this->outcomes_model->getByTags($type, $tags, $limit);

    // change outcomes to string
    if ($outcomes) {
      foreach ($outcomes as $key => $outcome) {
        $outcomes[$key] = $outcome['content'];
      }
    }

    $this->_json(TRUE, 'outcomes', $outcomes);

    // clo content only when suggesting ilos
    // $clo_content = $this->input->post('cloContent') ? $this->input->post('cloContent') : FALSE;
    // $ilosFromClos = $this->outcomes_model->getILOsFromCLOs($clo_content, $cloLimit);
  }
}

?>
