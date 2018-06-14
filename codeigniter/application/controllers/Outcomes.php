<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('outcomes_model');
  }
  
  public function index() {
    $type = $this->input->post('type') ? $this->input->post('type') : FALSE;
    $detailed = $this->input->post('detailed') ? $this->input->post('detailed') : FALSE;
    $strict = $this->input->post('strict') ? $this->input->post('strict') : FALSE;
    $limit = $this->input->post('limit') ? $this->input->post('limit') : FALSE;
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : FALSE;

    $where = array();
    if ($type) {
      $where['type'] = $type;
    }
    if ($strict) {
      $where['status !='] = 0;
    }
    
    $outcomes = $this->outcomes_model->getByQuery($search, $where, $limit, $detailed);

    if (!$detailed) {
      // change outcomes to string if not detailed
      if ($outcomes) {
        foreach ($outcomes as $key => $outcome) {
          $outcomes[$key] = $outcome['content'];
        }
      }
    } else {
      $outcomes = $this->_formatOutcomes($outcomes);
    }

    $this->_json(TRUE, 'outcomes', $outcomes);
  }

  public function suggest() {
    $type = $this->input->post('type');
    $course_id = $this->input->post('courseId');
    $books = $this->input->post('books') ? $this->input->post('books') : FALSE;
    $topics = $this->input->post('topics') ? $this->input->post('topics') : FALSE;
    $limit = $this->input->post('limit');

    // type 1 = clo
    // type 2 = ilo
    // type 3 = tla faculty
    // type 4 = tla student

    $tags = array();

    // get tags of course, books, and topics
    $tags = $this->_g_getTagsOfCourse($course_id, $tags);
    $tags = $this->_g_getTagsOfBooks($books, $tags);
    $tags = $this->_g_getTagsOfTopics($topics, $tags);

    // unique tags
    $tags = array_unique($tags);

    // get outcomes
    $outcomes = $this->outcomes_model->getByTags($type, $tags, $limit);

    // change outcomes to string
    if ($outcomes) {
      foreach ($outcomes as $key => $outcome) {
        $outcomes[$key] = $outcome['content'];
      }
    }

    $this->_json(TRUE, 'outcomes', $outcomes);

    // clo content only when suggesting ilos
    // $clo_content = $this->input->post('cloContent') ? $this->input->post('cloContent') : FALSE;
    // $ilosFromClos = $this->outcomes_model->getILOsFromCLOs($clo_content, $cloLimit);
  }

  public function manage() {
    $content = $this->input->post('content');
    $type = $this->input->post('type');
    $status = $this->input->post('status');

    $tags = $this->input->post('tags');

    // options
    $mode = $this->input->post('mode');

    $TIME = time();

    $data = array(
      'content' => $content,
      'type' => $type,
      'status' => $status,
      'tags' => $tags,
      'updated_at' => $TIME
    );

    $res = FALSE;
    if ($mode == 'add') {
      $data['created_at'] = $TIME;
      $res = $this->outcomes_model->insert($data);
    } else if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->outcomes_model->update($data, array('id' => $id));
    }

    if ($res) {
      // insert new tags
      $this->load->model('tags_model');
      $this->tags_model->insertMultiple(json_decode($tags, TRUE));
    }

    $this->_json($res);
  }

  public function delete() {
    $id = $this->input->post('id');

    $data = array('status' => -1, 'updated_at' => time());
    $where = array('id' => $id);

    $res = $this->outcomes_model->update($data, $where);
    $this->_json($res);
  }
}

?>
