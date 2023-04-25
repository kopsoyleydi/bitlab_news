package classes;

import com.sun.jdi.ArrayReference;

import java.sql.*;
import java.util.ArrayList;

public class DBManager {

    private static Connection connection;
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection
                    ("jdbc:mysql://localhost:3306/bit_lab_news?useUnicode=true&serverTimezone=UTC",
                            "root",""
                    );
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public static User getUser(String email){
        User people = null;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT * FROM users WHERE email = ? LIMIT 1");
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                people = new User();
                people.setId(resultSet.getLong("id"));
                people.setEmail(resultSet.getString("email"));
                people.setPassword(resultSet.getString("password"));
                people.setFullName(resultSet.getString("full_name"));
                people.setRole(resultSet.getString("role"));
            }
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return people;
    }

    public static boolean addUser(User user){
        int rows = 0;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO users (email, password, full_name, role)" +
                    "VALUES (?,?,?,?)");

            statement.setString(1,user.getEmail());
            statement.setString(2,user.getPassword());
            statement.setString(3, user.getFullName());
            statement.setString(4, user.getRole());

            rows = statement.executeUpdate();
            statement.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return rows > 0;
    }
    public static boolean addBlog(Blog blog){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO blogs (user_id, title, content, post_date, url) " +
                    "VALUES (?, ?, ?, NOW(),?)");
            statement.setLong(1, blog.getUser().getId());
            statement.setString(2, blog.getTitle());
            statement.setString(3, blog.getContent());
            statement.setString(4,blog.getUrl());
            rows = statement.executeUpdate();
            statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }

    public static ArrayList<Blog> getAllBlogs(){
        ArrayList<Blog> blogs = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT b.id, b.title, b.content, b.post_date, b.user_id, b.url, u.full_name, u.email " +
                    "FROM blogs b " +
                    "INNER JOIN users u ON u.id = b.user_id " +
                    "ORDER BY b.post_date DESC ");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                Blog blog = new Blog();
                blog.setId(resultSet.getLong("id"));
                blog.setTitle(resultSet.getString("title"));
                blog.setContent(resultSet.getString("content"));
                blog.setPostDate(resultSet.getTimestamp("post_date"));
                User user = new User();
                user.setId(resultSet.getLong("user_id"));
                user.setEmail(resultSet.getString("email"));
                user.setFullName(resultSet.getString("full_name"));
                blog.setUser(user);
                blog.setUrl(resultSet.getString("url"));
                blogs.add(blog);
            }
            statement.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return blogs;
    }

}
