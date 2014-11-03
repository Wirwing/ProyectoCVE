<?php 

class Model extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'modelos';

	var $new_indicators;

	static $has_many = array(
		array('indicators', 'class_name' => 'Indicator', 'foreign_key' => 'id_modelo')
		);

	static $after_create = array('make_indicators');

	static $before_update = array('update_indicators');

	public function update_indicators(){

		if($this->new_indicators){
			foreach ($this->new_indicators as $indicator_attributes) {

				$indicator = Indicator::find($indicator_attributes["id"]);
				$indicator->update_attributes($indicator_attributes);
				
			}
		}

	}

	public function make_indicators() {
		if($this->new_indicators){
			foreach ($this->new_indicators as $indicator) {
				$this->create_indicator($indicator);
			}
		}
	}

}

?>