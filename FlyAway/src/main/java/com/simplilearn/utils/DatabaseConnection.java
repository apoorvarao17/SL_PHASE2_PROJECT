package com.simplilearn.utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DatabaseConnection {
    
    public static Connection getConnection() {
        Connection connection = null;
        
        String driver_class_name = "com.mysql.cj.jdbc.Driver";
        String user = "root"; // change it
        String password = "Bhruguni17"; // change it
        String url = "jdbc:mysql://localhost:3306/airlinereservations?useSSL=false"; // change its
        try {
            //step #1 : load a driver class
            Class.forName(driver_class_name);
            
            //step #2 : establish  the connection
            connection = DriverManager.getConnection(url, user, password);
            
        }catch(ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        
        return connection;
    }
}