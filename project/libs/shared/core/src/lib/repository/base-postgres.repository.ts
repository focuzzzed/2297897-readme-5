import { DefaultPOJOType, Entity, EntityIdType } from "./entity.interface";
import { PrismaClientService } from '@project/libs/shared/posts/models';
import { Repository } from "./repository.interface";

export abstract class BasePostgresRepository<
  EntityType extends Entity<EntityIdType, DocumentType>,
  DocumentType = DefaultPOJOType
> implements Repository<EntityType, DocumentType> {

  constructor(
    protected readonly client: PrismaClientService,
    private readonly createEntity: (document: DocumentType) => EntityType,
  ) { }

  protected createEntityFromDocument(document: DocumentType) {
    if(!document) {
      return null;
    }

    return this.createEntity(document);
  }

  public async findById(id: EntityType["id"]): Promise<EntityType> {
    throw new Error('Not Implemented');
  }

  public async save(entity: EntityType): Promise<EntityType> {
    throw new Error('Not Implemented');
  }

  public async update(id: EntityType["id"], entity: EntityType): Promise<EntityType> {
    throw new Error('Not Implemented');
  }

  public async deleteById(id: EntityType["id"]): Promise<void> {
    throw new Error('Not Implemented');
  }
}
