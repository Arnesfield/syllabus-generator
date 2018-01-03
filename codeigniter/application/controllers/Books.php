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
    echo json_encode(array('books' => $books));
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $limit = $this->input->post('limit');
    $books = $this->books_model->getRelatedBooksToCourseId($course_id, $limit);
    echo json_encode(array('books' => $books));
  }
}

?>
