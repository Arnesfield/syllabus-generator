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
    $book_ids = $this->input->post('bookIds');
    $outcomes = $this->_filter($this->input->post('outcomes'));
    $curriculum_id = $this->input->post('curriculumId');
    $limit = $this->input->post('limit');

    // get fields of course
    // get selected outcomes (both CLO and ILO)
    // get fields of books selected
    // get fields of topics

    $cFields = $this->fields_model->getFieldsByCourseId($course_id);
    $bFields = $this->fields_model->getFieldsByBookIds($book_ids);
    $fields = array();
    if (is_array($cFields)) {
      foreach ($cFields as $field) {
        array_push($fields, $field['field_id']);
      }
    }
    if (is_array($bFields)) {
      foreach ($bFields as $field) {
        // if not yet in array, include it
        if (!in_array($field['field_id'], $fields)) {
          array_push($fields, $field['field_id']);
        }
      }
    }

    // iclude both clo and ilo content
    $topics = $this->topics_model->getRelatedTopicsWithFieldsAndOutcomes($fields, $outcomes, $limit);
    $topics = $this->topics_model->_to_col($topics, 'name');
    $this->_json(TRUE, 'topics', $topics);
  }
}

?>
