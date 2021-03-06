package com.neu.prattle.service;

import com.neu.prattle.model.Message;
import com.neu.prattle.service.api.MessageAPI;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MessageServiceImpl implements MessageService {
  private static final Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
  private static MessageService messageService;

  static {
    messageService = new MessageServiceImpl();
  }

  private MessageAPI api = new MessageAPI();


  /**
   * Call this method to return an instance of this service.
   *
   * @return this
   */

  public static MessageService getInstance() {
    return messageService;
  }

  /**
   * Set the api used by Message Service.
   *
   * @param messageAPI message api
   */
  @Override
  public void setAPI(MessageAPI messageAPI) {
    api = messageAPI;
  }

  @Override
  public List<Message> getAllPrivateMessages(String fromName, String toName) {
    List<Message> allMessages = new ArrayList<>();
    try {
      allMessages = api.getAllPrivateMessages(fromName, toName);
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    }
    return allMessages;
  }

  @Override
  public boolean addMessage(Message message) {
    boolean rst = false;
    try{
      rst = api.addMessage(message);
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    }
    return rst;
  }

  @Override
  public List<Message> getAllGroupMessages(int groupId) {
    List<Message> allMessages = new ArrayList<>();
    try {
      allMessages = api.getAllGroupMessages(groupId);
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    }
    return allMessages;
  }

  /**
   * Get user chat history for government to watch
   */
  @Override
  public List<Message> getUserLog(String username) {
    return api.getUserLog(username);
  }
}
