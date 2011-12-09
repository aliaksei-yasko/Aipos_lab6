/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package alex.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Alexei Yasko
 * Class that provide methods for
 * working whith weapon data base
 */
public class Performer {

    private Connection connection = null;

    /**
     * Performer constructor
     * @param dataSourceRef reference for data source
     * @throws NamingException
     * @throws SQLException
     */
    public Performer(String dataSourceRef) throws NamingException, SQLException {

        Context    initContext = null;
        Context    envContext = null;
        DataSource dataSource = null;
        /* Get data source from context */
        initContext = new InitialContext();
        envContext = (Context) initContext.lookup("java:comp/env");
        dataSource = (DataSource)envContext.lookup(dataSourceRef);
        /* Get connection to data base from data source */
        connection = dataSource.getConnection();
    }

    /**
     * Function that provides updating weapon object
     * @param weapon - updated weapon object
     * @return
     */
    public boolean updateWeapon(Weapon weapon) {
        try {
            /* Update data base */
            String update = "UPDATE Weapons SET typeweapon = ?, weightweapon = ?, " + "lengthweapon = ?, caliberweapon = ?, speadweapon = ? " + "WHERE nameweapon = ?";
            PreparedStatement statement;
            statement = connection.prepareStatement(update);
            statement.setString(1, weapon.getType());
            statement.setDouble(2, weapon.getWeight());
            statement.setDouble(3, weapon.getLength());
            statement.setDouble(4, weapon.getCaliber());
            statement.setDouble(5, weapon.getSpeadOfTheBullet());
            statement.setString(6, weapon.getName());
            int check = statement.executeUpdate();
            /* Return logical result of operation */
            if (check == 0) {
                return false;
            } else {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Function that provides obtaining information about weapon
     * @param nameWeapon weapon name
     * @return
     */
    public Weapon getWeaponByName(String nameWeapon) {
        try {
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
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
