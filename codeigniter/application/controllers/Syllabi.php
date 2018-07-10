<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('syllabi_model');
  }
  
  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : '';
    $courseId = $this->input->post('courseId') ? $this->input->post('courseId') : FALSE;
    $noEmpty = $this->input->post('noEmpty') ? $this->input->post('noEmpty') : FALSE;
    
    $where = array();
    if ($courseId) {
      $where['course_id'] = $courseId;
    }
    
    if ($noEmpty) {
      $where['version !='] = '';
    }

    $syllabi = $this->syllabi_model->getByQuery($search, $where);
    $syllabi = $this->_formatSyllabi($syllabi);
    $this->_json(TRUE, 'syllabi', $syllabi);
  }

  public function suggest() {
    // suggest the latest, duh
    $courseId = $this->input->post('courseId');
    $where = array('course_id' => $courseId);
    $syllabi = $this->syllabi_model->getLatest($where);
    $syllabi = $this->_formatSyllabi($syllabi);
    $this->_json(TRUE, 'syllabi', $syllabi);
  }

  public function outcomes() {
    $outcomes = $this->input->post('outcomes') ? $this->input->post('outcomes') : array();

    // based on outcomes,
    // add them to where clause
    // per content, add "" join with %
    $like = array();


    $append = function($outcomes, $i, $start = '', $end = '') {
      if (!array_key_exists($i, $outcomes)) {
        return array();
      }

      $list = array();
      foreach ($outcomes[$i] as $key => $value) {
        array_push($list, $start.'"'.$value.'"'.$end);
      }
      return $list;
    };
    
    $clo = $append($outcomes, 1, '"courseLearningOutcomes":%', '%"weeklyActivities":');
    $ilo = $append($outcomes, 2, '"ilo":%');
    $tlaFaculty = $append($outcomes, 3, '"tlaFaculty":%');
    $tlaStudent = $append($outcomes, 4, '"tlaStudent":%');

    $like = array_merge($clo, $ilo, $tlaFaculty, $tlaStudent);
    
    $syllabi = $this->syllabi_model->getByContent($like);
    $syllabi = $this->_formatSyllabi($syllabi);
    $this->_json(TRUE, 'syllabi', $syllabi);
  }

  public function save($return = FALSE) {
    $assignId = $this->input->post('assignId');
    $syllabus = $this->input->post('syllabus');

    // check if syllabus with assign id exists
    // if not, insert one with that ^^ $syllabus
    // else, just update that ^^ $syllabus

    $this->load->model('assigns_model');
    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      if ($return) {
        return FALSE;
      } else {
        $this->_json(FALSE);
      }
    }

    // get course id
    $assign = $assigns[0];
    $content = json_decode($assign['content'], TRUE);
    $cid = $content['course'];

    // get uid
    $uid = $this->session->userdata('user')['id'];

    $syllabi = $this->syllabi_model->getByAssignId($assignId);

    if (!$syllabi) {
      // insert new here
      $data = array(
        'course_id' => $cid,
        'editor_id' => $uid,
        'assign_id' => $assignId,
        'content' => $syllabus,
        'version' => '',
        'created_at' => time(),
        'updated_at' => time(),
        'status' => 2
      );
      $res = $this->syllabi_model->insert($data);

      if ($res) {
        $syllabi_2 = $this->syllabi_model->getByAssignId($assignId);
        $sid = $syllabi_2[0]['id'];
        $this->_insert_trail('generator', 1, array('content' => "Saved Syllabus $sid"));
      }

      if ($return) {
        return $res;
      } else {
        $this->_json($res);
      }
    }

    // update here
    $fetchedSyllabus = $syllabi[0];
    $sid = $fetchedSyllabus['id'];

    $data = array(
      'content' => $syllabus,
      'updated_at' => time()
    );

    $res = $this->syllabi_model->update($data, array('id' => $sid));

    if ($res) {
      $this->_insert_trail('generator', 1, array('content' => "Saved Syllabus $sid"));
    }

    if ($return) {
      return $res;
    } else {
      $this->_json($res);
    }
  }

  public function submit() {
    $res = $this->save(true);

    if (!$res) {
      $this->_json(FALSE);
    }

    // assigns model already loaded
    $assignId = $this->input->post('assignId');

    $data = array(
      'status' => 2,
      'updated_at' => time()
    );
    $where = array('id' => $assignId);

    $res = $this->assigns_model->update($data, $where);

    if ($res) {
      $syllabi = $this->syllabi_model->getByAssignId($assignId);
      $sid = $syllabi[0]['id'];
      $this->_insert_trail('generator', 2, array('content' => "Submitted Syllabus $sid"));
    }

    $this->_json($res);
  }
}

?>
