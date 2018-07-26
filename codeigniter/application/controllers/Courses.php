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
    $withRelated = $this->_filter_bool('withRelated');
    $withSyllabi = $this->_filter_bool('withSyllabi');
    $deep = $this->_filter_bool('deep');
    $formatSyllabi = $this->_filter_bool('formatSyllabi');
    $withAssign = $this->_filter_bool('withAssign');
    $exceptId = $this->input->post('exceptId') ? $this->input->post('exceptId') : FALSE;
    $cid = $this->input->post('cid') ? $this->input->post('cid') : FALSE;
    $sid = $this->input->post('sid') ? $this->input->post('sid') : FALSE;
    $log = $this->_filter_bool('log');
    $logSyllabus = $this->_filter_bool('logSyllabus');
    $limit = $this->_getPostLimit();
    
    $where = array();
    if ($exceptId) {
      $where['id !='] = $exceptId;
    }
    if ($cid) {
      $where['id'] = $cid;
    }

    $courses = $this->courses_model->getByQuery($search, $where, $limit);
    $courses = $this->_formatCourses($courses, $withRelated, $deep);

    if ($withSyllabi) {
      // get id of course
      $course_ids = array_map(function($e) {
        return $e['id'];
      }, $courses);

      if ($course_ids) {
        $this->load->model('syllabi_model');

        // also load assigns
        $assigns = array();
        if ($withAssign && $sid) {
          $assigns = $this->syllabi_model->getAssignIdById($sid);
          if (!$assigns) {
            $this->_json(FALSE);
          }
          $this->load->model('assigns_model');
          $assigns = $this->_createAssigns($assigns);

          // convert to id => value
          $newAssigns = array();
          foreach ($assigns as $key => $value) {
            $newAssigns[$value['id']] = $value;
          }
        }

        $where = array('version !=' => '');
        $syllabi = $this->syllabi_model->getByQuery(FALSE, $where, $course_ids);

        if ($formatSyllabi) {
          $syllabi = $this->_formatSyllabi($syllabi);
        }

        // loop through courses
        foreach ($courses as $index => $course) {
          $courses[$index]['syllabi'] = $curr_syllabi = array_filter($syllabi, function($e) use ($course) {
            return $e['course_id'] == $course['id'];
          });

          if ($withAssign && $sid) {
            // loop through assigns
            // if same id as related ids
            foreach ($curr_syllabi as $sIndex => $syllabus) {
              if ($syllabus['id'] == $sid && $syllabus['course_id'] == $course['id']) {
                $courses[$index]['assign'] = $newAssigns[$syllabus['assign_id']];
                break;
              }
            }
          }
        }
      }
    }

    if ($log && $courses) {
      $cid = $courses[0]['id'];

      // if requesting for tree
      if ($withRelated && $deep) {
        $this->_insert_trail('course', 2, array(
          'course_id' => $cid,
          'content' => "Viewed Course $cid Tree"
        ));
      } else {
        $this->_insert_trail('course', 1, array(
          'course_id' => $cid,
          'content' => "Viewed Course $cid"
        ));
      }
    }
    
    if ($logSyllabus) {
      $this->_insert_trail('syllabus', 1, array(
        'syllabus_id' => $sid,
        'content' => "Viewed Syllabus $sid"
      ));
    }

    $this->_json(TRUE, 'courses', $courses);
  }

  public function addCsv() {
    $courses = $this->input->post('courses');
    $res = $this->courses_model->insertMultiple($courses);

    if ($res) {
      $this->_insert_trail('manage_courses', 4);
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
    $res = $this->courses_model->update($data, $where);

    if ($res) {
      $this->_insert_trail('manage_courses', 3, array(
        'course_id' => $id,
        'content' => "Deleted Course $id"
      ));
    }

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
      // insert trail
      $trail = array();
      if ($mode == 'add') {
        $trail['type'] = 1;
        $trail['data'] = array();
      } else if ($mode == 'edit') {
        $trail['type'] = 2;
        $trail['data'] = array(
          'course_id' => $id,
          'content' => "Updated Course $id"
        );
      } else {
        $trail = FALSE;
      }

      if ($trail !== FALSE) {
        $this->_insert_trail('manage_courses', $trail['type'], $trail['data']);
      }

      // insert new tags
      $this->load->model('tags_model');
      $this->tags_model->insertMultiple(json_decode($tags, TRUE));
    }

    $this->_json($res);
  }
}

?>
