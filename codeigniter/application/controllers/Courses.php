<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('courses_model');
  }
  
  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : '';
    $withRelated = $this->input->post('withRelated') ? $this->input->post('withRelated') : FALSE;
    $exceptId = $this->input->post('exceptId') ? $this->input->post('exceptId') : FALSE;
    
    $where = FALSE;
    if ($exceptId) {
      $where = array('id !=' => $exceptId);
    }

    $courses = $this->courses_model->getByQuery($search, $where);
    $courses = $this->_formatCourses($courses, $withRelated);
    $this->_json(TRUE, 'courses', $courses);
  }

  public function related() {
    $id = $this->input->post('id');

    // prereq type 1
    // coreq type 2

    $prerequisites = $this->courses_model->getRelatedCoursesById($id, 1);
    $corequisites = $this->courses_model->getRelatedCoursesById($id, 2);
    $this->_json(TRUE, array(
      'prerequisites' => $prerequisites,
      'corequisites' => $corequisites
    ));
  }

  public function assign_id() {
    $assignId = $this->input->post('assignId') ? $this->input->post('assignId') : FALSE;

    if (!$assignId) {
      $this->_json(FALSE);
    }
    
    // get assign
    $this->load->model('assigns_model');
    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
    }

    $assign = $assigns[0];
    $content = json_decode($assign['content'], TRUE);

    $uid = $this->session->userdata('user')['id'];

    // if uid is not the same as assigned, do not proceed
    if ($uid != $content['assigned']['id']) {
      $this->_json(FALSE);
    }

    // get course id from assign
    $cid = $content['course'];

    $courses = $this->courses_model->getWhere(array('id' => $cid));

    if (!$courses) {
      $this->_json(FALSE);
    }

    $course = $courses[0];
    $data = array('course' => $course);
    
    // also send the syllabi if it exists
    $this->load->model('syllabi_model');
    $syllabi = $this->syllabi_model->getByAssignId($assignId);

    if ($syllabi) {
      // if syllabus exists
      $data['syllabus'] = $syllabi[0];
    }

    $data['assign'] = $assign;
    $this->_json(TRUE, $data);
  }

  public function addCsv() {
    $courses = $this->input->post('courses');
    $res = $this->courses_model->insertMultiple($courses);
    $this->_json($res);
  }

  public function delete() {
    $id = $this->input->post('id');
    $data = array(
      'status' => -1,
      'updated_at' => time()
    );
    $where = array('id' => $id);
    $res = $this->courses_model->update($data, $where);
    $this->_json($res);
  }

  public function manage() {
    $title = $this->input->post('title');
    $code = $this->input->post('code');
    $description = $this->input->post('description');
    $objectives = $this->input->post('objectives');
    $unitsLec = $this->input->post('unitsLec');
    $unitsLab = $this->input->post('unitsLab');
    $status = $this->input->post('status');

    $tags = $this->input->post('tags');
    $prerequisites = $this->input->post('prerequisites');
    $corequisites = $this->input->post('corequisites');

    // options
    $mode = $this->input->post('mode');

    $TIME = time();

    $data = array(
      'title' => $title,
      'code' => $code,
      'description' => $description,
      'objectives' => $objectives,
      'unitsLec' => $unitsLec,
      'unitsLab' => $unitsLab,
      'status' => $status,
      'tags' => $tags,
      'prerequisites' => $prerequisites,
      'corequisites' => $corequisites,
      'updated_at' => $TIME
    );

    $res = FALSE;
    if ($mode == 'add') {
      $data['created_at'] = $TIME;
      $res = $this->courses_model->insert($data);
    } else if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->courses_model->update($data, array('id' => $id));
    }

    if ($res) {
      // insert new tags
      $this->load->model('tags_model');
      $this->tags_model->insertMultiple(json_decode($tags, TRUE));
    }

    $this->_json($res);
  }
}

?>
