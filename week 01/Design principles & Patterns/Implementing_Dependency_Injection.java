interface CustomerRepository {
    String findCustomerById(int customerId);
}

class CustomerRepositoryImpl implements CustomerRepository {

    @Override
    public String findCustomerById(int customerId) {

        if (customerId == 101) {
            return "Mihir Bansal";
        } else if (customerId == 102) {
            return "Aman Sharma";
        } else if (customerId == 103) {
            return "Priya Verma";
        }

        return "Customer Not Found";
    }
}

class CustomerService {

    private CustomerRepository customerRepository;

    CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public void getCustomerDetails(int customerId) {
        String customer = customerRepository.findCustomerById(customerId);

        System.out.println("Customer ID : " + customerId);
        System.out.println("Customer Name : " + customer);
    }
}

public class Implementing_Dependency_Injection {

    public static void main(String[] args) {

        CustomerRepository customerRepository = new CustomerRepositoryImpl();

        CustomerService customerService =
                new CustomerService(customerRepository);

        customerService.getCustomerDetails(101);

        System.out.println();

        customerService.getCustomerDetails(103);

        System.out.println();

        customerService.getCustomerDetails(105);
    }
}