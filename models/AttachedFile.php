<?php 

class AttachedFile extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'archivos_adjuntos';

	static $belongs_to = array(
    	array('activity', 'foreign_key' => 'id_actividad', 'class_name' => 'Activity')
	);

	static $before_destroy = array('destroy_file');

    public static function attach_new($id_actividad) {

		$activity = Activity::find($id_actividad);

		if (!isset($_FILES['file'])) {
			$result = array( 'message' => 'No files attached' );
			return;
		}

		$file = $_FILES['file'];
		$filename = $file['tmp_name'];

		$upload_path = '/cve/public/uploads/activities/'. $activity->id . '/files';
		$destination =  $upload_path . '/' . $file["name"];

		if ($file['error'] === 0) {

			if (!file_exists($upload_path)) {
				mkdir($upload_path, 0777, true);
			}

			if (move_uploaded_file($filename, $destination)){
				$result = AttachedFile::create_new($file["name"], $activity->id);
			}
			else{
				$result = array( 'message' => 'Error on transfer' );
			}
			

		}else{

			$result = array( 'message' => 'Error code' );
		}

		return $result;
		
	}

	public static function find_by_id_and_activity($id, $id_activity){

		$attachments = AttachedFile::all(array('id_actividad' => $id_activity, 'id' => $id));

		if(sizeof($attachments) == 0) 
			throw new \ActiveRecord\RecordNotFound("Couldn't find attachment");

		return $attachments[0];

	}

	public function destroy_file(){
		$file = $this->get_attachment();
		unlink($file);
	}

	public function get_attachment(){
		return "C:\cve\public\uploads\activities\\" . $this->id_actividad . "\\files\\" . $this->nombre;
	}

	private static function create_new($filename, $id_activity){
		$attributes = array('nombre' => $filename, 'url' => '', 'fecha' =>  new \DateTime(), 'id_actividad' => $id_activity);
		return AttachedFile::create($attributes);
	}

}

?>