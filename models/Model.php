<?php 

class Model extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'modelos';

    // TODO implement the class adding methods
    var $classes_;

    static $has_many = array(
        array('classes', 'class_name' => 'HabClass')
    );

    static $after_create = array('set_classes');

    static $before_update = array('update_classes');

    public function set_classes(){
        if( $this->classes_ ){
            foreach( $this->classes_ as $model_class_attrs ){
                $model_class = new HabClass($model_class_attrs);
                $model_class->save();
            }
        }
    }

    public function update_classes(){
        foreach( $this->classes_ as $model_class_attrs ){
            $model_class = HabClass::find( $model_class_attrs["id"] );
            $model_class->update_attributes($model_class_attrs);
        }
    }

}
?>