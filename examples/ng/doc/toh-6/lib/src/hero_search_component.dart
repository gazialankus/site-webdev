// #docplaster
// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';

import 'route_paths.dart' as paths;
import 'hero_search_service.dart';
import 'hero.dart';

@Component(
  selector: 'hero-search',
  templateUrl: 'hero_search_component.html',
  styleUrls: ['hero_search_component.css'],
  directives: [coreDirectives],
  providers: [const ClassProvider(HeroSearchService)],
  pipes: [commonPipes],
)
class HeroSearchComponent implements OnInit {
  HeroSearchService _heroSearchService;
  Router _router;

  // #docregion search
  Stream<List<Hero>> heroes;
  // #enddocregion search
  // #docregion searchTerms
  StreamController<String> _searchTerms =
      StreamController<String>.broadcast();
  // #enddocregion searchTerms

  HeroSearchComponent(this._heroSearchService, this._router) {}
  // #docregion searchTerms

  // Push a search term into the stream.
  void search(String term) => _searchTerms.add(term);
  // #enddocregion searchTerms
  // #docregion search

  Future<void> ngOnInit() async {
    heroes = _searchTerms.stream
        .transform(debounce(Duration(milliseconds: 300)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<Hero>>.fromIterable([<Hero>[]])
            : _heroSearchService.search(term).asStream()))
        .handleError((e) {
      print(e); // for demo purposes only
    });
  }
  // #enddocregion search

  String _heroUrl(int id) =>
      paths.hero.toUrl(parameters: {paths.idParam: id.toString()});

  Future<NavigationResult> gotoDetail(Hero hero) =>
      _router.navigate(_heroUrl(hero.id));
}
