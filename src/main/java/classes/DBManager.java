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
                people.setRole_id(resultSet.getLong("role_id"));
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
                    "INSERT INTO users (email, password, full_name, role, role_id)" +
                    "VALUES (?,?,?,?,?)");

            statement.setString(1,user.getEmail());
            statement.setString(2,user.getPassword());
            statement.setString(3, user.getFullName());
            statement.setString(4, user.getRole());
            statement.setLong(5,user.getRole_id());
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

    public static Blog getBlog(Long id){
        Blog blog = null;
        try {
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT b.id, b.title, b.content, b.post_date, b.user_id, b.url, u.full_name, u.email," +
                    " u.password,u.role ,u.role_id  " +
                    "FROM blogs b " +
                    "INNER JOIN users u ON u.id = b.user_id " +
                    "WHERE b.id = ? " +
                    "ORDER BY b.post_date DESC ");
            statement.setLong(1,id);

            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                blog = new Blog();
                blog.setId(resultSet.getLong("id"));
                User user = new User();
                user.setId(resultSet.getLong("user_id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setPassword(resultSet.getString("password"));
                user.setEmail(resultSet.getString("email"));
                user.setRole(resultSet.getString("role"));
                user.setRole_id(resultSet.getLong("role_id"));
                blog.setUser(user);
                blog.setTitle(resultSet.getString("title"));
                blog.setContent(resultSet.getString("content"));
                blog.setUrl(resultSet.getString("url"));
                blog.setPostDate(resultSet.getTimestamp("post_date"));
            }
            statement.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return blog;
    }
    public static boolean addComment(Comment comment){
        int rows = 0;
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "INSERT INTO comments (user_id, blog_id, comment, post_date) " +
                    "VALUES (?, ?, ?, NOW()) ");
            statement.setLong(1, comment.getUser().getId());
            statement.setLong(2, comment.getBlog().getId());
            statement.setString(3, comment.getComment());

            rows = statement.executeUpdate();
            statement.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return rows>0;
    }
    public static ArrayList<Comment> getAllComments(Long blogId){
        ArrayList<Comment> comments = new ArrayList<>();
        try{
            PreparedStatement statement = connection.prepareStatement("" +
                    "SELECT c.id, c.user_id, c.comment, c.blog_id, u.full_name, u.email, c.post_date " +
                    "FROM comments c " +
                    "INNER JOIN users u ON c.user_id = u.id " +
                    "WHERE c.blog_id = ? " +
                    "ORDER BY c.post_date DESC");
            statement.setLong(1, blogId);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                Comment comment = new Comment();
                comment.setId(resultSet.getLong("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPostDate(resultSet.getTimestamp("post_date"));
                User user = new User();
                user.setId(resultSet.getLong("user_id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                comment.setUser(user);
                Blog blog = new Blog();
                blog.setId(resultSet.getLong("blog_id"));
                comment.setBlog(blog);
                comments.add(comment);
            }
            statement.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return comments;
    }

}
