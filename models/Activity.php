<?php 

class Activity extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'actividades_colaborativas';

	//Modelo padre
	static $belongs_to = array(
    	array('model', 'foreign_key' => 'id_modelo', 'class_name' => 'Model')
	);

	//0...* archivos adjuntos
	static $has_many = array(
		array('attachments', 'class_name' => 'AttachedFile', 'foreign_key' => 'id_actividad')
	);

	//Delega el atributo indicators a model, de esta forma podemos hacer activity.indicators en vez de activity.model.indicators
	//static $delegate = array(
    //  array('indicators' => 'model')
    //);

	//Callback que destroye adjuntos antes de eliminar una actividad
	static $before_destroy = array('destroy_attachments');

	public function destroy_attachments(){

		foreach ($this->attachments as $attachment ) {
			$attachment->delete();
  		}

	}

}

?>