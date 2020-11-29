import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContatoDao extends Mock implements ContatoDAO {}
class MockTransactionWebClient extends Mock implements TransactionWebClient {}
