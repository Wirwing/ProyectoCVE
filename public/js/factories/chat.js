(function () {

    var app = angular.module('chatsFactory', ['ngResource']);

    app.factory('Chats', ['$resource',function($resource){
        return $resource("/cve/api/chat/messages", {}, {
            sendMessage: { method: 'POST' },
            sendElement: { url: "/cve/api/chat/elements", method: 'POST' },
            getPreviousMessages: { url: "/cve/api/chat/messages/:group_id/:activity_id", method: 'GET', isArray: true },
            getMessages: { url: "/cve/api/chat/messages/:group_id/:activity_id/:last_chat_id", method: 'GET', isArray: true },
            all: { url: "/cve/api/chat/group/:group_id/activity/:activity_id/messages", method: 'GET', isArray: true }

        });
    }]);

})();
