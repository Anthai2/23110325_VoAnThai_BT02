package service;

import dao.CategoryDao;
import dao.CategoryDaoImpl;
import model.Category;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private final CategoryDao dao = new CategoryDaoImpl();

    @Override public boolean insert(Category c) { return dao.insert(c); }
    @Override public boolean update(Category c) { return dao.update(c); }
    @Override public boolean delete(int id)     { return dao.delete(id); }

    @Override public Category findById(int id)        { return dao.findById(id); }
    @Override public Category findByName(String name)  { return dao.findByName(name); }

    @Override public List<Category> findAll()                { return dao.findAll(); }
    @Override public List<Category> searchByName(String kw)  { return dao.searchByName(kw); }
}
