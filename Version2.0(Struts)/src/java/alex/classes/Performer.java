/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package alex.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Admin
 */
public class Performer {
    private String resourceName = "";
    Connection connection = null;

    public Performer(String aResourceName) throws NamingException, SQLException{
        resourceName = aResourceName;
        Context    initContext = null;
        DataSource dataSource = null;
        /* Get data source from context */
        initContext = new InitialContext();
        dataSource = (DataSource)initContext.lookup(resourceName);
        /* Get connection to data base from data source */
        connection = dataSource.getConnection();
    }

    public boolean changeWeapon (Weapon updateWeapon, String oldName) throws SQLException {
       String insertQuery =
                    "UPDATE ALEX.WEAPONS SET NAMEWEAPON=?, TYPEWEAPON=?, WEIGHTWEAPON=?, "
                    + "LENGTHWEAPON=?, CALIBERWEAPON=?, SPEADWEAPON=? WHERE  NAMEWEAPON=?";

        /* Executing query to our data base */
        PreparedStatement statment = connection.prepareStatement(insertQuery);

        statment.setString(1, updateWeapon.getName());
        statment.setString(2, updateWeapon.getType());
        statment.setDouble(3, updateWeapon.getWeight());
        statment.setDouble(4, updateWeapon.getLength());
        statment.setDouble(5, updateWeapon.getCaliber());
        statment.setDouble(6, updateWeapon.getSpeadOfTheBullet());
        statment.setString(7, oldName);

        int result = statment.executeUpdate();

        if (result != 0) {
            return true;
        } else {
            return false;
        }
    }

    public Weapon getWeaponByName(String nameWeapon) throws SQLException {
        /* Select data from data base about current weapon */
        String query = "select * from weapons where weapons.nameweapon = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, nameWeapon);
        ResultSet result = statement.executeQuery();
        if (!result.next()) {
            return null;
        } else {
            /* Create weapon object from receved data */
            Weapon weapon = new Weapon();
            weapon.setName(result.getString("nameweapon"));
            weapon.setType(result.getString("typeweapon"));
            weapon.setWeight(result.getDouble("weightweapon"));
            weapon.setLength(result.getDouble("lengthweapon"));
            weapon.setCaliber(result.getDouble("caliberweapon"));
            weapon.setSpeadOfTheBullet(result.getDouble("speadweapon"));

            return weapon;
       }
    }

    public boolean addWeapon(Weapon newWeapon) throws SQLException {
        String insertQuery =
                    "INSERT INTO ALEX.WEAPONS VALUES(?, ?, ?, ?, ?, ?)";

            /* Executing query to our data base */
            PreparedStatement statment = connection.prepareStatement(insertQuery);

            statment.setString(1, newWeapon.getType());
            statment.setString(2, newWeapon.getName());
            statment.setDouble(3, newWeapon.getWeight());
            statment.setDouble(4, newWeapon.getLength());
            statment.setDouble(5, newWeapon.getCaliber());
            statment.setDouble(6, newWeapon.getSpeadOfTheBullet());

            int result = statment.executeUpdate();

            if (result != 0) {
                return true;
            } else {
                return false;
            }
    }

    public boolean deleteWeapon(String weaponName) throws SQLException {
        String deleteQuery =
                    "DELETE FROM ALEX.WEAPONS WHERE WEAPONS.NAMEWEAPON=?";
            /* Executing query to our data base */
            PreparedStatement statment = connection.prepareStatement(deleteQuery);
            statment.setString(1, weaponName);
            int result = statment.executeUpdate();
            if (result != 0) {
                return true;
            } else {
                return false;
            }
    }

    public Weapon[] getAllWeapon() throws SQLException, NamingException {
        
        /* Executing query to our data base */
        Statement statment = connection.createStatement();
        ResultSet resultLen = statment.executeQuery("SELECT * FROM ALEX.WEAPONS");

        /* Calculate how mach record we have */
        int length = 0;
        while(resultLen.next()) {
            length++;
        }

        Weapon[] weapons = new Weapon[length];
        length = 0;

        ResultSet result = statment.executeQuery("SELECT * FROM ALEX.WEAPONS");
        /* Translate obtained record to weapon objects */
        while(result.next()){
            Weapon weapon = new Weapon();
            weapon.setType(result.getString("TypeWeapon"));
            weapon.setName(result.getString("NameWeapon"));
            weapon.setWeight(result.getDouble("WeightWeapon"));
            weapon.setLength(result.getDouble("LengthWeapon"));
            weapon.setCaliber(result.getDouble("CaliberWeapon"));
            weapon.setSpeadOfTheBullet(result.getDouble("SpeadWeapon"));
            weapons[length] = weapon;
            length++;
        }

        return weapons;
    }
}
