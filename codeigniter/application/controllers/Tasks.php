<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tasks extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('tasks_model');
  }
  
  public function index() {
    $search = $this->_filter($this->input->post('search'));
    $tasks = $this->tasks_model->getByQuery($search);
    $tasks = $this->tasks_model->_to_col($tasks, 'name');
    $this->_json(TRUE, 'tasks', $tasks);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $books = $this->input->post('books') ? $this->input->post('books') : FALSE;
    $topics = $this->input->post('topics') ? $this->input->post('topics') : FALSE;
    $curriculum_id = $this->input->post('curriculumId');
    $limit = $this->input->post('limit');

    $tags = array();

    // get tags of course, books, and topics
    $tags = $this->_g_getTagsOfCourse($course_id, $tags);
    $tags = $this->_g_getTagsOfBooks($books, $tags);
    $tags = $this->_g_getTagsOfTopics($topics, $tags);

    // unique tags
    $tags = array_unique($tags);

    // get tasks
    $tasks = $this->tasks_model->getByTags($tags, $limit);
    $tasks = $this->tasks_model->_to_col($tasks, 'name');
    $this->_json(TRUE, 'tasks', $tasks);
  }
}

?>
