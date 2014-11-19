<?php

class Group extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'grupos_colaborativos';

  var $users_ids;

  static $has_many = array(
    array('group_users', 'class_name' => 'GroupUser'),
    array('users', 'class_name' => 'User',  'through' => 'group_users'),
  );

  static $after_create = array('set_users');

  public function set_users(){
    foreach ($this->users_ids as $user_id ) {
      $group_user_attr = array(
        'group_id' => $this->id,
        'user_id' => $user_id,
      );
      $groupUser = new GroupUser($group_user_attr);
      $groupUser->save();
    }
  }

  static $before_destroy = array('unlink_users');

  public function unlink_users(){
    foreach ($this->group_users as $group_user ) {
      $group_user->delete();
    }
  }

}

?>
