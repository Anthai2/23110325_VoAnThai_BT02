package dao;

import model.User;
import util.DBConnection;

import java.sql.*;

public class UserDaoImpl implements UserDao {

	@Override
	public User findByUserNameAndPassword(String username, String password) {
	    if (username == null || username.isBlank() || password == null || password.isBlank()) return null;

	    // DÙNG RTRIM/LTRIM để tránh khoảng trắng thừa trong DB
	    final String sql =
	        "SELECT id,email,username,fullname,[password],avatar,roleid,phone,createdDate " +
	        "FROM dbo.[User] WHERE RTRIM(LTRIM(username)) = ? AND RTRIM(LTRIM([password])) = ?";

	    try (Connection conn = new DBConnection().getConnection()) {

	        // In DB hiện tại để chắc chắn đúng DB
	        try (PreparedStatement ping = conn.prepareStatement("SELECT DB_NAME() db");
	             ResultSet pr = ping.executeQuery()) {
	            if (pr.next()) System.out.println(">>> DB = " + pr.getString("db"));
	        }

	        try (PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, username.trim());
	            ps.setString(2, password.trim());
	            try (ResultSet rs = ps.executeQuery()) {
	                System.out.println(">>> Query login username=" + username);
	                if (rs.next()) {
	                    User u = new User();
	                    u.setId(rs.getInt("id"));
	                    u.setEmail(rs.getString("email"));
	                    u.setUserName(rs.getString("username"));
	                    u.setFullName(rs.getString("fullname"));
	                    u.setPassWord(rs.getString("password"));
	                    u.setAvatar(rs.getString("avatar"));
	                    u.setRoleid(rs.getInt("roleid"));
	                    u.setPhone(rs.getString("phone"));
	                    u.setCreatedDate(rs.getDate("createdDate"));
	                    return u;
	                } else {
	                    System.out.println(">>> No row matched username+password");
	                }
	            }
	        }
	    } catch (Exception e) {
	        System.out.println(">>> DAO login ERROR: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return null;
	}
    @Override
    public boolean insert(User user) {
        final String sql =
            "INSERT INTO dbo.[User](email,username,fullname,[password],avatar,roleid,phone,createdDate) " +
            "VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println(">>> DAO ERROR insert: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null || email.isEmpty()) return false;
        final String sql = "SELECT 1 FROM dbo.[User] WHERE email = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (Exception e) {
            System.out.println(">>> DAO ERROR checkExistEmail: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null || username.isEmpty()) return false;
        final String sql = "SELECT 1 FROM dbo.[User] WHERE username = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username.trim());
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (Exception e) {
            System.out.println(">>> DAO ERROR checkExistUsername: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null || phone.isEmpty()) return false;
        final String sql = "SELECT 1 FROM dbo.[User] WHERE phone = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, phone.trim());
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (Exception e) {
            System.out.println(">>> DAO ERROR checkExistPhone: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean updatePasswordByEmailPhone(String email, String phone, String newPassword) {
        final String sql = "UPDATE dbo.[User] SET [password] = ? WHERE email = ? AND phone = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.setString(3, phone);
            int n = ps.executeUpdate();
            System.out.println("[FORGOT] email=" + email + ", phone=" + phone + ", updated=" + n);
            return n > 0;
        } catch (Exception e) {
            System.out.println(">>> DAO ERROR updatePasswordByEmailPhone: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

	@Override
	public User findByUserName(String username) {
		// TODO Auto-generated method stub
		return null;
	}
}
