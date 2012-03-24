
package org.tempuri;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="CheckTotalPaidResult" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "checkTotalPaidResult"
})
@XmlRootElement(name = "CheckTotalPaidResponse")
public class CheckTotalPaidResponse {

    @XmlElement(name = "CheckTotalPaidResult")
    protected double checkTotalPaidResult;

    /**
     * Gets the value of the checkTotalPaidResult property.
     * 
     */
    public double getCheckTotalPaidResult() {
        return checkTotalPaidResult;
    }

    /**
     * Sets the value of the checkTotalPaidResult property.
     * 
     */
    public void setCheckTotalPaidResult(double value) {
        this.checkTotalPaidResult = value;
    }

}
