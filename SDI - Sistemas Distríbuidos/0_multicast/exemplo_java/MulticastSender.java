import java.io.*;
import java.net.*;
/**
 * @author lycog
 * https://www.iana.org/assignments/multicast-addresses/multicast-addresses.xhtml
 */
public class MulticastSender {
  public static void main(String[] args) {
    DatagramSocket socket = null;
    DatagramPacket outPacket = null;
    byte[] outBuf;
    final int PORT = 8888;
 
    try {
      socket = new DatagramSocket();
      long counter = 0;
      String msg;
 
      while (true) {
        msg = "This is multicast! " + counter;
        counter++;
        outBuf = msg.getBytes();
 
        //Send to multicast IP address and port
        //InetAddress address = InetAddress.getByName("224.0.0.1");
        InetAddress address = InetAddress.getByName("224.0.0.2");
        outPacket = new DatagramPacket(outBuf, outBuf.length, address, PORT);
 
        socket.send(outPacket);
 
        System.out.println("Server sends : " + msg);
        try {
          Thread.sleep(500);
        } catch (InterruptedException ie) {
        }
      }
    } catch (IOException ioe) {
      System.out.println(ioe);
    }
  }
}
