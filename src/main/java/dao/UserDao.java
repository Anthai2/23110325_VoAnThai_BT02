package dao;

import model.User;

public interface UserDao {
    User findByUserName(String username);
    boolean insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    User findByUserNameAndPassword(String username, String password);
}
