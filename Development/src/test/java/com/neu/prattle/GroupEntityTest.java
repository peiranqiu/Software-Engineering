package com.neu.prattle;

import com.neu.prattle.model.Group;
import com.neu.prattle.model.User;

import junit.framework.TestCase;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class GroupEntityTest {


  @Test
  public void test1() {
    Group group1 = new Group();

    group1.setGroupId(4);
    assertEquals(4, group1.getGroupId());
    group1.setName("group1");
    assertEquals("group1", group1.getName());
    group1.setPassword("test");
    assertEquals("test", group1.getPassword());

  }

  @Test
  public void test2() {
    Group group2 = new Group("group2");
    User user = new User("user1");
    User member = new User();
    member.setName("member1");
    User moderator = new User();
    moderator.setName("moderator1");
    moderator.setModerator(true);
    assertTrue(moderator.getModerator());

  }

  @Test
  public void test4() {
    Group group4 = new Group("group4");
    Group group5 = new Group("group4");
    Group group6 = new Group("group6");
    assertEquals(group4, group5);
    assertFalse(group4.equals(group6));
    TestCase.assertFalse(group4.equals(1));
    assertTrue(group4.hashCode() == group5.hashCode());

  }


}
