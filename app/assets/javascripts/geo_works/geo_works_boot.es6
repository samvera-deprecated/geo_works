import ChildWorks from "geo_works/relationships/child_works"
import ParentWorks from "geo_works/relationships/parent_works"
export default class Initializer {
  constructor() {
    this.child_works = new ChildWorks('#child-works')
    this.parent_works = new ParentWorks('#parent-works')
  }
}
