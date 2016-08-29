module TasksHelper
  def class_file_template
    class_file = <<~HEREDOC
      import java.util.*;

      public class Classfile {
          public static void main (String[] args) {
              // scanner can be used to read from SDTIN
              // see: https://docs.oracle.com/javase/7/docs/api/java/util/Scanner.html
              Scanner scanner = new Scanner(System.in);
          }
      }
    HEREDOC
  end

  def basic_test_template
    class_file = <<~HEREDOC
      import static org.junit.Assert.*;
      import org.junit.*;

      // junit based testing
      // see: https://github.com/junit-team/junit4/wiki
      public class BasicTest {

          @BeforeClass
          public static void setUpBeforeClass() throws Exception {
          }

          @AfterClass
          public static void tearDownAfterClass() throws Exception {
          }

          @Before
          public void setUp() throws Exception {
          }

          @After
          public void tearDown() throws Exception {
          }

          @Test
          public void test() {
              fail("Not yet implemented");
          }
      }
    HEREDOC
  end

  def advanded_test_template
    class_file = <<~HEREDOC
      import static org.junit.Assert.*;
      import org.junit.*;

      // junit based testing
      // see: https://github.com/junit-team/junit4/wiki
      public class AdvancedTest {

          @BeforeClass
          public static void setUpBeforeClass() throws Exception {
          }

          @AfterClass
          public static void tearDownAfterClass() throws Exception {
          }

          @Before
          public void setUp() throws Exception {
          }

          @After
          public void tearDown() throws Exception {
          }

          @Test
          public void test() {
              fail("Not yet implemented");
          }
      }
    HEREDOC
  end
end
