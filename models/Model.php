<?php 

class Model extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'modelos';

	var $new_indicators;

	static $has_many = array(
		array('indicators', 'class_name' => 'Indicator', 'foreign_key' => 'id_modelo')
		);

	static $after_create = array('make_indicators');

	public function make_indicators() {
		if($this->new_indicators){
			foreach ($this->new_indicators as $indicator) {
				$this->create_indicator($indicator);
			}
		}
	}

}

?>