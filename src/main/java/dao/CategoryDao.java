package dao;

import java.util.List;
import model.Category;

public interface CategoryDao {
    boolean insert(Category c);
    boolean update(Category c);
    boolean delete(int id);

    Category findById(int id);
    Category findByName(String name);

    List<Category> findAll();
    List<Category> searchByName(String keyword);
}
