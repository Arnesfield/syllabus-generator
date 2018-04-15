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
    $withSyllabi = $this->input->post('withSyllabi') ? $this->input->post('withSyllabi') : FALSE;
    $exceptId = $this->input->post('exceptId') ? $this->input->post('exceptId') : FALSE;
    $cid = $this->input->post('cid') ? $this->input->post('cid') : FALSE;
    
    $where = array();
    if ($exceptId) {
      $where['id !='] = $exceptId;
    }
    if ($cid) {
      $where['id'] = $cid;
    }

    $courses = $this->courses_model->getByQuery($search, $where);
    $courses = $this->_formatCourses($courses, $withRelated);

    if ($withSyllabi) {
      // get id of course
      $course_ids = array_map(function($e) {
        return $e['id'];
      }, $courses);

      if ($course_ids) {
        $this->load->model('syllabi_model');
        $where = array('version !=' => '');
        $syllabi = $this->syllabi_model->getByQuery(FALSE, $where, $course_ids);

        // loop through courses
        foreach ($courses as $index => $course) {
          $courses[$index]['syllabi'] = array_filter($syllabi, function($e) use ($course) {
            return $e['course_id'] == $course['id'];
          });
        }
      }
    }

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
