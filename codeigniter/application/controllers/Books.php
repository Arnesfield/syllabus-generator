<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('books_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $search = strip_tags(trim(addslashes($this->input->post('search'))));
    $books = $this->books_model->getByQuery($search);
    $this->_json('books', $books);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $limit = $this->input->post('limit');
    $fields = $this->fields_model->getFieldsByCourseId($course_id);
    foreach ($fields as $key => $field) {
      $fields[$key] = $field['field_id'];
    }
    $books = $this->books_model->getRelatedBooksWithFields($fields, $limit);
    $this->_json('books', $books);
  }
}

?>
