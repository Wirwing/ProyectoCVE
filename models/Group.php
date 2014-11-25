<?php

class Group extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'grupos_colaborativos';

  var $users_ids;
  var $activity_id;

  static $has_many = array(
    array('group_users', 'class_name' => 'GroupUser'),
    array('users', 'class_name' => 'User',  'through' => 'group_users'),
  );

  static $after_create = array('set_users_and_activity');

  /* Sets the relation between users and an activity */
  public function set_users_and_activity(){
    foreach ($this->users_ids as $user_id ) {
      $group_user_attr = array(
        'group_id' => $this->id,
        'user_id' => $user_id,
      );

      $group_user_attr['activity_id'] = $this->activity_id;
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

  static $after_update = array("update_group");

  public function update_group(){
    /* unlink users */
    foreach ($this->group_users as $group_user ) {
      $group_user->delete();
    }

    foreach ($this->users_ids as $user_id ) {
      $group_user_attr = array(
        'group_id' => $this->id,
        'user_id' => $user_id,
      );

      if( $this->activity_id != -1 ){
        $group_user_attr['activity_id'] = $this->activity_id;
      }

      $groupUser = new GroupUser($group_user_attr);
      $groupUser->save();
    }
  }

}

?>
