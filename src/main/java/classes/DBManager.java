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
}
