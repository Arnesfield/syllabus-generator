<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('books_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : '';
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

  public function only() {
    $books = $this->books_model->get();
    $this->_json('books', $books);
  }

  public function add() {
    $post_values = array('citation', 'status');
    foreach ($post_values as $value) {
      $course[$value] = $this->_filter($this->input->post($value));
    }
    $res = $this->books_model->insert($course);
    $this->_json('success', $res);
  }

  public function addCsv() {
    $books = $this->input->post('books');
    foreach ($books as $key => $book) {
      $books[$key]['citation'] = $this->_filter($book['citation']);
    }
    $res = $this->books_model->insertMultiple($books);
    $this->_json('success', $res);
  }
}

?>
