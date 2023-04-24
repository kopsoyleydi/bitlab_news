package classes;

import java.sql.*;

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
}
