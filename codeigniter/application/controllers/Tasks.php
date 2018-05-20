<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tasks extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('tasks_model');
    $this->load->model('fields_model');
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

    return;

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
    $tasks = $this->tasks_model->_to_col($tasks, 'name');
    $this->_json(TRUE, 'tasks', $tasks);
  }
}

?>
