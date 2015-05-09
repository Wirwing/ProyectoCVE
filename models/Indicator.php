<?php 

class Indicator extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'indicadores';

    static $belongs_to = array(
        array('class', 'foreign_key' => 'class_id', 'class_name' => 'HabClass')
    );

}

?>