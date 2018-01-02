<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Books extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('books_model');
    $this->load->library('session');
  }
  
  public function index() {
    $search = strip_tags(trim(addslashes($this->input->post('search'))));
    $books = $this->books_model->getByQuery($search);
    $fields = $this->books_model->getFields();
    echo json_encode(array(
      'books' => $books,
      'fields' => $fields
    ));
  }

  public function suggest() {
    if (!($limit = $this->uri->segment(3)) || !is_numeric($limit)) {
      $limit = 10;
    }

    $course_id = $this->input->post('courseId');
    $books = $this->books_model->getRelatedBooksToCourseId($course_id, $limit);
    
    // use ids from $books for fields
    $suggestedBooks = array();
    foreach ($books as $key => $book) {
      $suggestedBooks[$key] = $book['b_id'];
    }

    $fields = $this->books_model->getFields($suggestedBooks);
    echo json_encode(array(
      'books' => $books,
      'fields' => $fields,
      // testing
      'limit' => $limit,
      'course_id' => $course_id
    ));
  }
}

?>
