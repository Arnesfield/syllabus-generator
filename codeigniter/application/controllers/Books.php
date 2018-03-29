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
    $books = $this->books_model->_to_col($books, 'citation');
    $this->_json(TRUE, 'books', $books);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $limit = $this->input->post('limit');
    $fields = $this->fields_model->getFieldsByCourseId($course_id);
    foreach ($fields as $key => $field) {
      $fields[$key] = $field['field_id'];
    }
    $books = $this->books_model->getRelatedBooksWithFields($fields, $limit);
    $books = $this->books_model->_to_col($books, 'citation');
    $this->_json(TRUE, 'books', $books);
  }

  public function only() {
    $books = $this->books_model->get();
    $books = $this->_formatBooks($books);
    $this->_json(TRUE, 'books', $books);
  }

  public function addCsv() {
    $books = $this->input->post('books');
    $res = $this->books_model->insertMultiple($books);
    $this->_json($res);
  }

  public function delete() {
    $id = $this->input->post('id');
    $data = array(
      'status' => -1,
      'updated_at' => time()
    );
    $where = array('id' => $id);
    $res = $this->books_model->update($data, $where);
    $this->_json($res);
  }

  public function manage() {
    $citation = $this->input->post('citation');
    $tags = $this->input->post('tags');
    $status = $this->input->post('status');

    // options
    $mode = $this->input->post('mode');

    $TIME = time();
    
    $data = array(
      'citation' => $citation,
      'tags' => $tags,
      'updated_at' => $TIME,
      'status' => $status
    );

    if ($mode == 'add') {
      $data['created_at'] = $TIME;
    }

    if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->books_model->update($data, array('id' => $id));
    }
    else {
      $res = $this->books_model->insert($data);
    }

    // insert new tags
    $this->load->model('tags_model');
    $this->tags_model->insertMultiple(json_decode($tags, TRUE));

    $this->_json($res);
  }
}

?>
