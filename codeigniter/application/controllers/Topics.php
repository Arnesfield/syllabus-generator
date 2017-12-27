<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('topics_model');
    $this->load->library('session');
  }
  
  public function index() {
    $search = strip_tags(trim(addslashes($this->input->post('search'))));
    $topics = $this->topics_model->getByQuery($search);
    $fields = $this->topics_model->getFields();
    echo json_encode(array(
      'topics' => $topics,
      'fields' => $fields
    ));
  }

  public function suggest() {
    if (!($limit = $this->uri->segment(3)) || !is_numeric($limit)) {
      $limit = 10;
    }

    $course_id = $this->input->post('courseId');
    $topics = $this->topics_model->getRelatedBooksToCourseId($course_id, $limit);
    $fields = $this->topics_model->getFields();
    echo json_encode(array(
      'topics' => $topics,
      'fields' => $fields,
      // testing
      'limit' => $limit,
      'course_id' => $course_id
    ));
  }
}

?>
