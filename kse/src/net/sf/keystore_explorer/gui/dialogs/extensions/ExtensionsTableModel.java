/*
 * Copyright 2004 - 2013 Wayne Grant
 *           2013 Kai Kramer
 *
 * This file is part of KeyStore Explorer.
 *
 * KeyStore Explorer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * KeyStore Explorer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with KeyStore Explorer.  If not, see <http://www.gnu.org/licenses/>.
 */
package net.sf.keystore_explorer.gui.dialogs.extensions;

import java.security.cert.X509Extension;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.TreeMap;

import javax.swing.table.AbstractTableModel;

import net.sf.keystore_explorer.crypto.x509.X509Ext;

import org.bouncycastle.asn1.ASN1ObjectIdentifier;

/**
 * The table model used to display X.509 extensions.
 * 
 */
public class ExtensionsTableModel extends AbstractTableModel {
	private static ResourceBundle res = ResourceBundle
			.getBundle("net/sf/keystore_explorer/gui/dialogs/extensions/resources");

	private String[] columnNames;
	private Object[][] data;

	/**
	 * Construct a new ExtensionsTableModel.
	 */
	public ExtensionsTableModel() {
		columnNames = new String[3];
		columnNames[0] = res.getString("ExtensionsTableModel.CriticalColumn");
		columnNames[1] = res.getString("ExtensionsTableModel.NameColumn");
		columnNames[2] = res.getString("ExtensionsTableModel.OidColumn");

		data = new Object[0][0];
	}

	/**
	 * Load the ExtensionsTableModel with X.509 extensions.
	 * 
	 * @param extensions
	 *            The X.509 extensions
	 */
	public void load(X509Extension extensions) {
		Set critExts = extensions.getCriticalExtensionOIDs();
		Set nonCritExts = extensions.getNonCriticalExtensionOIDs();

		// Rows will be sorted by extension name
		TreeMap<String, X509Ext> sortedExts = new TreeMap<String, X509Ext>(new ExtensionNameComparator());

		for (Iterator itr = critExts.iterator(); itr.hasNext();) {
			String extOid = (String) itr.next();
			byte[] value = extensions.getExtensionValue(extOid);

			X509Ext ext = new X509Ext(new ASN1ObjectIdentifier(extOid), value, true);

			sortedExts.put(ext.getName(), ext);
		}

		for (Iterator itr = nonCritExts.iterator(); itr.hasNext();) {
			String extOid = (String) itr.next();
			byte[] value = extensions.getExtensionValue(extOid);

			X509Ext ext = new X509Ext(new ASN1ObjectIdentifier(extOid), value, false);

			sortedExts.put(ext.getName(), ext);
		}

		data = new Object[sortedExts.size()][3];

		int i = 0;
		for (Iterator itrSortedExts = sortedExts.entrySet().iterator(); itrSortedExts.hasNext();) {
			X509Ext ext = (X509Ext) ((Map.Entry) itrSortedExts.next()).getValue();
			loadRow(ext, i);
			i++;
		}

		fireTableDataChanged();
	}

	private void loadRow(X509Ext extension, int row) {
		data[row][0] = new Boolean(extension.isCriticalExtension());

		String name = extension.getName();

		if (name == null) {
			data[row][1] = "";
		} else {
			data[row][1] = name;
		}

		data[row][2] = extension.getOid();
	}

	/**
	 * Get the number of columns in the table.
	 * 
	 * @return The number of columns
	 */
	public int getColumnCount() {
		return columnNames.length;
	}

	/**
	 * Get the number of rows in the table.
	 * 
	 * @return The number of rows
	 */
	public int getRowCount() {
		return data.length;
	}

	/**
	 * Get the name of the column at the given position.
	 * 
	 * @param col
	 *            The column position
	 * @return The column name
	 */
	public String getColumnName(int col) {
		return columnNames[col];
	}

	/**
	 * Get the cell value at the given row and column position.
	 * 
	 * @param row
	 *            The row position
	 * @param col
	 *            The column position
	 * @return The cell value
	 */
	public Object getValueAt(int row, int col) {
		return data[row][col];
	}

	/**
	 * Get the class at of the cells at the given column position.
	 * 
	 * @param col
	 *            The column position
	 * @return The column cells' class
	 */
	public Class<?> getColumnClass(int col) {
		switch (col) {
		case 0:
			return Boolean.class;
		case 1:
			return String.class;
		default:
			return ASN1ObjectIdentifier.class;
		}
	}

	/**
	 * Is the cell at the given row and column position editable?
	 * 
	 * @param row
	 *            The row position
	 * @param col
	 *            The column position
	 * @return True if the cell is editable, false otherwise
	 */
	public boolean isCellEditable(int row, int col) {
		return false;
	}

	private class ExtensionNameComparator implements Comparator<String> {
		public int compare(String name1, String name2) {
			if (name1 == null) {
				name1 = "";
			}

			if (name2 == null) {
				name2 = "";
			}

			return name1.compareToIgnoreCase(name2);
		}
	}
}