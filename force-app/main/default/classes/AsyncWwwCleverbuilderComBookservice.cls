//Generated by wsdl2apex

public class AsyncWwwCleverbuilderComBookservice {
    public class AddBookResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwCleverbuilderComBookservice.Book_element getValue() {
            wwwCleverbuilderComBookservice.AddBookResponse_element response = (wwwCleverbuilderComBookservice.AddBookResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.Book;
        }
    }
    public class GetAllBooksResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwCleverbuilderComBookservice.Book_element[] getValue() {
            wwwCleverbuilderComBookservice.GetAllBooksResponse_element response = (wwwCleverbuilderComBookservice.GetAllBooksResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.Book;
        }
    }
    public class GetBookResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwCleverbuilderComBookservice.Book_element getValue() {
            wwwCleverbuilderComBookservice.GetBookResponse_element response = (wwwCleverbuilderComBookservice.GetBookResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.Book;
        }
    }
    public class AsyncBookServiceSOAP {
        public String endpoint_x = 'http://www.example.org/BookService';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.cleverbuilder.com/BookService/', 'wwwCleverbuilderComBookservice'};
        public AsyncWwwCleverbuilderComBookservice.AddBookResponse_elementFuture beginAddBook(System.Continuation continuation,wwwCleverbuilderComBookservice.Book_element Book) {
            wwwCleverbuilderComBookservice.AddBook_element request_x = new wwwCleverbuilderComBookservice.AddBook_element();
            request_x.Book = Book;
            return (AsyncWwwCleverbuilderComBookservice.AddBookResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwCleverbuilderComBookservice.AddBookResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://www.cleverbuilder.com/BookService/AddBook',
              'http://www.cleverbuilder.com/BookService/',
              'AddBook',
              'http://www.cleverbuilder.com/BookService/',
              'AddBookResponse',
              'wwwCleverbuilderComBookservice.AddBookResponse_element'}
            );
        }
        public AsyncWwwCleverbuilderComBookservice.GetAllBooksResponse_elementFuture beginGetAllBooks(System.Continuation continuation) {
            wwwCleverbuilderComBookservice.GetAllBooks_element request_x = new wwwCleverbuilderComBookservice.GetAllBooks_element();
            return (AsyncWwwCleverbuilderComBookservice.GetAllBooksResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwCleverbuilderComBookservice.GetAllBooksResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://www.cleverbuilder.com/BookService/GetAllBooks',
              'http://www.cleverbuilder.com/BookService/',
              'GetAllBooks',
              'http://www.cleverbuilder.com/BookService/',
              'GetAllBooksResponse',
              'wwwCleverbuilderComBookservice.GetAllBooksResponse_element'}
            );
        }
        public AsyncWwwCleverbuilderComBookservice.GetBookResponse_elementFuture beginGetBook(System.Continuation continuation,String ID) {
            wwwCleverbuilderComBookservice.GetBook_element request_x = new wwwCleverbuilderComBookservice.GetBook_element();
            request_x.ID = ID;
            return (AsyncWwwCleverbuilderComBookservice.GetBookResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwCleverbuilderComBookservice.GetBookResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://www.cleverbuilder.com/BookService/GetBook',
              'http://www.cleverbuilder.com/BookService/',
              'GetBook',
              'http://www.cleverbuilder.com/BookService/',
              'GetBookResponse',
              'wwwCleverbuilderComBookservice.GetBookResponse_element'}
            );
        }
    }
}