package service;

import dao.UserDao;
import dao.UserDaoImpl;
import model.User;
import java.sql.Date;

public class UserServiceImpl implements UserService {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) return null;
        username = username.trim();
        password = password.trim();

        User user = userDao.findByUserNameAndPassword(username, password);
        System.out.println("[LOGIN] username=" + username + ", matched=" + (user != null));
        return user;
    }


    @Override
    public User findByUserName(String username) {
        return (username == null) ? null : userDao.findByUserName(username.trim());
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (username == null || password == null) return false;
        username = username.trim();
        password = password.trim();
        email    = (email == null ? null : email.trim());
        fullname = (fullname == null ? null : fullname.trim());
        phone    = (phone == null ? null : phone.trim());

        // kiểm tra trùng
        if (userDao.checkExistUsername(username)
                || (email != null && userDao.checkExistEmail(email))
                || (phone != null && !phone.isEmpty() && userDao.checkExistPhone(phone))) {
            return false;
        }

        // tạo user mới với roleid = 5 (Customer)
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        User user = new User(email, username, fullname, password, null, 5, phone, date);

        return userDao.insert(user);
    }
    @Override
    public boolean resetPasswordByEmailPhone(String email, String phone, String newPassword) {
        if (email == null || phone == null || newPassword == null) return false;
        return userDao.updatePasswordByEmailPhone(email.trim(), phone.trim(), newPassword.trim());
    }

    @Override
    public boolean insert(User user) {
        return userDao.insert(user);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }


	@Override
	public boolean updatePasswordByEmailPhone(String email, String phone, String newPassword) {
		// TODO Auto-generated method stub
		return false;
	}
}
