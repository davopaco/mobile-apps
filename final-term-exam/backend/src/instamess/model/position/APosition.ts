export default abstract class APosition {
  constructor(protected id: number, protected name: string) {}

  getId(): number {
    return this.id;
  }

  getName(): string {
    return this.name;
  }

  setId(id: number): void {
    this.id = id;
  }

  setName(name: string): void {
    this.name = name;
  }
}
