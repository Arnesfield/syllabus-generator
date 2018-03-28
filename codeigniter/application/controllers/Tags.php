<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tags extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('tags_model');
  }

  public function index() {
    $search = $this->_filter($this->input->post('search'));
    $tags = $this->tags_model->getByQuery($search);
    $tags = $this->tags_model->_to_col($tags, 'title');
    
    $this->_json(TRUE, 'tags', $tags);
  }
}

?>
