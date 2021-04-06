abstract class IService<IEntity> {
  Future<void> create(IEntity entity, {String key = ""});
  Future<List<IEntity>> readAll({String key = ""});
  Future<IEntity> read(String id, {String key = ""});
  Future<void> update(String id, IEntity entity, {String key = ""});
  Future<void> delete(String id, {String key = ""});
}