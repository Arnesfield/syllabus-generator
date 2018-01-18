<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tasks extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('tasks_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $search = strip_tags(trim(addslashes($this->input->post('search'))));
    $tasks = $this->tasks_model->getByQuery($search);
    $this->_json('tasks', $tasks);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $book_ids = $this->input->post('bookIds') ? $this->input->post('bookIds') : FALSE;
    $topic_ids = $this->input->post('topicIds') ? $this->input->post('topicIds') : FALSE;
    $year = $this->input->post('curriculumYear');
    $limit = $this->input->post('limit');

    // get fields of course
    // get fields of books selected
    // get fields of tasks

    $cFields = $this->fields_model->getFieldsByCourseId($course_id);
    $bFields = $this->fields_model->getFieldsByBookIds($book_ids);
    $tTasks = $this->fields_model->getTasksByTopicIds($topic_ids);
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
    $tasksArr = array();
    if (is_array($tTasks)) {
      foreach ($tTasks as $task) {
        array_push($tasksArr, $task['task_id']);
      }
    }

    $tasks = $this->tasks_model->getRelatedTasksWithFields($fields, $limit, $tasksArr);
    $this->_json('tasks', $tasks);
  }
}

?>
