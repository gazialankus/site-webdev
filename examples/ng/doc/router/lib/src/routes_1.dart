import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart' as paths;
import 'crisis_list_component_1.template.dart' as clct;
import 'hero_list_component_1.template.dart' as hlct;

@Injectable()
class Routes {
  static final _crises = RouteDefinition(
    routePath: paths.crises,
    component: clct.CrisisListComponentNgFactory,
  );

  static final _heroes = RouteDefinition(
    routePath: paths.heroes,
    component: hlct.HeroListComponentNgFactory,
  );

  final crises = _crises;
  final heroes = _heroes;

  final List<RouteDefinition> all = [
    _crises,
    _heroes,
  ];
}
