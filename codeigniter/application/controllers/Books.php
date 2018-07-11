<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('books_model');
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

    // get tags of course using cid
    $this->load->model('courses_model');
    $courses = $this->courses_model->getByQuery(FALSE, array(
      'id' => $course_id
    ));

    if (!$courses) {
      $this->_json(FALSE);
    }

    $course = $this->_formatCourses($courses)[0];
    // parse json array
    $fields = $course['tags'];

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

    if ($res) {
      $this->_insert_trail('manage_books', 4);
    }

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

    if ($res) {
      $this->_insert_trail('manage_books', 3, array(
        'book_id' => $id,
        'content' => "Deleted Book $id"
      ));
    }

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

    $res = FALSE;
    if ($mode == 'add') {
      $data['created_at'] = $TIME;
      $res = $this->books_model->insert($data);
    } else if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->books_model->update($data, array('id' => $id));
    }

    if ($res) {
      // insert trail
      $trail = array();
      if ($mode == 'add') {
        $trail['type'] = 1;
        $trail['data'] = array();
      } else if ($mode == 'edit') {
        $trail['type'] = 2;
        $trail['data'] = array(
          'book_id' => $id,
          'content' => "Updated Book $id"
        );
      } else {
        $trail = FALSE;
      }

      if ($trail !== FALSE) {
        $this->_insert_trail('manage_books', $trail['type'], $trail['data']);
      }

      // insert new tags
      $this->load->model('tags_model');
      $this->tags_model->insertMultiple(json_decode($tags, TRUE));
    }

    $this->_json($res);
  }
}

?>
