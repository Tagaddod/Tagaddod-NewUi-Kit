import 'package:shelf_router/shelf_router.dart';
import 'routes/generate_route.dart';
import 'routes/manifest_route.dart';
import 'routes/search_route.dart';

Router buildRouter() {
  final router = Router();
  router.get('/api/manifest', manifestHandler);
  router.get('/api/search', searchHandler);
  router.post('/api/generate', generateHandler);
  return router;
}
