<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('curriculum_model');
  }
  
  /* public function index() {
    $year = $this->input->post('year');
    $curriculum = $this->curriculum_model->get($year);
    $this->_json(TRUE, 'curriculum', $curriculum);
  }

  public function years() {
    $limit = NULL;
    if ($this->uri->segment(3) === 'suggest') {
      $limit = 1;
    }
    $search = strtolower($this->_filter($this->input->post('search')));
    $years = $this->curriculum_model->getYearsByQuery($search, $limit);
    $this->_json(TRUE, 'years', $years);
  } */

  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : '';
    $limit = $this->_getPostLimit();

    $where = array();

    $existing = $this->input->post('existing') ? $this->input->post('existing') : FALSE;
    if ($existing) {
      $where['status !='] = 0;
    }
    
    $curriculum = $this->curriculum_model->getByQuery($search, $where, $limit);
    $curriculum = $this->_formatCurriculum($curriculum);
    $this->_json(TRUE, 'curriculum', $curriculum);
  }

  public function suggest() {
    // suggest the latest, duh
    $curriculum = $this->curriculum_model->getLatest();
    $curriculum = $this->_formatCurriculum($curriculum);
    $this->_json(TRUE, 'curriculum', $curriculum);
  }

  public function delete() {
    $id = $this->input->post('id');
    $data = array(
      'status' => -1,
      'updated_at' => time()
    );
    $where = array('id' => $id);
    $res = $this->curriculum_model->update($data, $where);

    if ($res) {
      $this->_insert_trail('manage_curriculum', 3, array(
        'curriculum_id' => $id,
        'content' => "Deleted Curriculum $id"
      ));
    }

    $this->_json($res);
  }

  public function manage() {
    $label = $this->input->post('label');
    $latest = $this->_filter_bool('latest');
    $status = $this->input->post('status');

    $content = $this->input->post('content');

    // options
    $mode = $this->input->post('mode');

    $TIME = time();

    $data = array(
      'label' => $label,
      'status' => $status,
      'content' => $content,
      'latest' => 0,
      'updated_at' => $TIME
    );

    if ($latest) {
      $data['latest'] = 1;
      // update all to 0
      $this->curriculum_model->update(
        array('latest' => 0),
        array('latest' => 1)
      );
    }

    $res = FALSE;
    if ($mode == 'add') {
      $data['created_at'] = $TIME;
      $res = $this->curriculum_model->insert($data);
    } else if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->curriculum_model->update($data, array('id' => $id));
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
          'curriculum_id' => $id,
          'content' => "Updated Curriculum $id"
        );
      } else {
        $trail = FALSE;
      }

      if ($trail !== FALSE) {
        $this->_insert_trail('manage_curriculum', $trail['type'], $trail['data']);
      }
    }

    $this->_json($res);
  }
}

?>
