<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logs extends MY_Custom_Controller {

  public function workflow() {
    $where = FALSE;
    if ($id = $this->input->post('id')) {
      $where = array('assign_id' => $id);
    }
    // get logs in workflow
    $logs = $this->logs_model->getWorkflow($where);
    $this->_json(TRUE, 'logs', $logs);
  }

  public function addWorkflow() {
    $aid = $this->input->post('id');
    $content = $this->input->post('content');
    $type = $this->input->post('type');

    $data = array(
      'assign_id' => $aid,
      'content' => $content,
      'type' => $type
    );

    $res = $this->_insertWorkflowLog($data);
    $this->_json($res);
  }
}

?>
