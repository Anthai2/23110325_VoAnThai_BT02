package service;

import dao.UserDao;
import dao.UserDaoImpl;
import model.User;

public class UserServiceImpl implements UserService {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = userDao.findByUserName(username);
        return (user != null && password.equals(user.getPassWord())) ? user : null;
    }

    @Override
    public User findByUserName(String username) {
        return userDao.findByUserName(username);
    }
}
