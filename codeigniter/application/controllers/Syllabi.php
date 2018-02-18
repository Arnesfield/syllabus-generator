<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('syllabi_model');
  }
  
  public function cid() {
    $course_id = $this->input->post('courseId');
    $syllabi = $this->syllabi_model->getByCourseId($course_id);
    $this->_json(TRUE, 'syllabi', $syllabi);
  }

  public function save() {
    $assignId = $this->input->post('assignId');
    $syllabus = $this->input->post('syllabus');

    // check if syllabus with assign id exists
    // if not, insert one with that ^^ $syllabus
    // else, just update that ^^ $syllabus

    $this->load->model('assigns_model');
    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
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
      $this->_json($res);
    }

    // update here
    $fetchedSyllabus = $syllabi[0];
    $sid = $fetchedSyllabus['id'];

    $data = array(
      'content' => $syllabus,
      'updated_at' => time()
    );

    $res = $this->syllabi_model->update($data, array('id' => $sid));
    $this->_json($res);
  }
}

?>
