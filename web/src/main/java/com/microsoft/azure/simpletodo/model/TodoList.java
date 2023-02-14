package com.microsoft.azure.simpletodo.model;

import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import javax.validation.constraints.*;
import org.springframework.data.annotation.Id;


import java.util.*;
import javax.annotation.Generated;

/**
 *  A list of related Todo items
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen")
public class TodoList {

  @JsonProperty("id")
  @Id
  private UUID id;

  @JsonProperty("name")
  private String name;

  @JsonProperty("description")
  private String description;

  public TodoList id(UUID id) {
    this.id = id;
    return this;
  }

  /**
   * Get id
   * @return id
   */

  public UUID getId() {
    return id;
  }

  public void setId(UUID id) {
    this.id = id;
  }

  public TodoList name(String name) {
    this.name = name;
    return this;
  }

  /**
   * Get name
   * @return name
   */
  @NotNull
  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public TodoList description(String description) {
    this.description = description;
    return this;
  }

  /**
   * Get description
   * @return description
   */

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    TodoList todoList = (TodoList) o;
    return Objects.equals(this.id, todoList.id) &&
            Objects.equals(this.name, todoList.name) &&
            Objects.equals(this.description, todoList.description);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, name, description);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class TodoList {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    name: ").append(toIndentedString(name)).append("\n");
    sb.append("    description: ").append(toIndentedString(description)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}

