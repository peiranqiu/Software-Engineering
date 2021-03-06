package com.neu.prattle.service;

import com.neu.prattle.model.Message;
import com.neu.prattle.service.api.MessageAPI;

import java.util.List;

/***
 * Acts as an interface between the data layer and the
 * servlet controller.
 *
 * The controller is responsible for interfacing with this instance
 * to perform all the CRUD operations on user accounts.
 *
 *
 */
public interface MessageService {

  /**
   * Set the message api used by this service
   */
  void setAPI(MessageAPI api);

  List<Message> getAllPrivateMessages(String fromName, String toName);

  boolean addMessage(Message message);

  List<Message> getAllGroupMessages(int groupId);

  List<Message> getUserLog(String username);

}
