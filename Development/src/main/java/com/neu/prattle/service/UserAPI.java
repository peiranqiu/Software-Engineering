package com.neu.prattle.service;

import com.neu.prattle.model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class are api for crud in user table.
 */
public class UserAPI extends DBUtils {

  private static final Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
  private PreparedStatement stmt = null;
  private ResultSet rs = null;

  public UserAPI() {
    super();
  }

  /**
   * Add a user the db
   *
   * @param user the user to add
   */
  public boolean addUser(User user) {

    int key = -1;
    con = getConnection();
    String sqlInsert = "INSERT INTO User (name, password, isModerator) VALUES (?, ?, ?)";
    try (PreparedStatement sttmt = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
      sttmt.setString(1, user.getName());
      sttmt.setString(2, user.getPassword());
      sttmt.setBoolean(3, false);
      sttmt.executeUpdate();
      ResultSet result = sttmt.getGeneratedKeys();
      if (result.next()) key = result.getInt(1);
      result.close();
    } catch (SQLException e) {
      throw new IllegalStateException("Create user failed.");
    }
    return key != -1;
  }

  /**
   * Fetch the user with the given name from db
   *
   * @param name the name of the user
   * @return if the user is in the db
   */
  public User getUserByName(String name)throws SQLException {
    String sql = "SELECT * FROM User WHERE name =?";
    return getUser(sql, -1, name);
  }

  /**
   * Fetch the user with the given id from db
   *
   * @param id the id of the user
   * @return if the user is in the db
   */
  public User getUserById(int id) throws SQLException {
    String sql = "SELECT * FROM User WHERE User_id =?";
    return getUser(sql, id, null);
  }

  /**
   * Helper method to get user with given name or id.
   * @param sql the sql query string
   * @param id the user id
   * @param name the user name
   * @return the user if exist
   * @throws SQLException
   */
  public User getUser(String sql, int id, String name) throws SQLException {
    try {
      con = getConnection();
      stmt = con.prepareStatement(sql);
      if(name == null) {
        stmt.setInt(1, id);
      }
      else {
        stmt.setString(1, name);
      }
      rs = stmt.executeQuery();
      if (rs.next()) {
        return constructUser(rs);
      }
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    } finally {
      rs.close();
      stmt.close();
    }
    return null;
  }

  /**
   * A helper method to construct a user with returned result set.
   * @param rs the result set
   * @return the user
   */
  public User constructUser(ResultSet rs) {
    User user = new User();
    try {
      user.setUserId(rs.getInt("User_id"));
      user.setName(rs.getString("name"));
      user.setPassword(rs.getString("password"));
      user.setModerator(rs.getBoolean("isModerator"));
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    }
    return user;
  }

  /**
   * Update user info with given new fields.
   * @param user the user to update
   * @param field the field to update
   * @param value the new value of the given field
   * @return the updated user
   * @throws SQLException
   */
  public User updateUser(User user, String field, String value) throws SQLException {
    String sql = "UPDATE User SET field = ? WHERE name = ?";
    sql = sql.replace("field", field);
    return executeUpdate(sql, user, value, false);
  }

  /**
   * Update user role.
   * @param user the user to update
   * @return the updated user
   * @throws SQLException
   */
  public User setModerator(User user) throws SQLException {
    String sql = "UPDATE User SET isModerator = ? WHERE name = ?";
    return executeUpdate(sql, user, null, user.getModerator());
  }

  /**
   * Helper method to update user information
   * @param sql the sql query string
   * @param user the user to be updated
   * @param value the string value to be update if exist
   * @param moderate the isModerator boolean value to be update if exist
   * @return the updated user
   * @throws SQLException
   */
  public User executeUpdate(String sql, User user, String value, boolean moderate) throws SQLException{
    try {
      con = getConnection();
      stmt = con.prepareStatement(sql);
      if(value == null) {
        stmt.setBoolean(1, moderate);
      }
      else {
        stmt.setString(1, value);
      }
      stmt.setString(2, user.getName());
      int result = stmt.executeUpdate();
      if (result == 1) {
        return user;
      }
    } catch (SQLException e) {
      LOGGER.log(Level.INFO, e.getMessage());
    } finally {
      rs.close();
      stmt.close();
    }
    return null;
  }
}
