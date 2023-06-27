package com.microsoft.azure.simpletodo.repository;

import com.microsoft.azure.simpletodo.model.TodoList;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TodoListRepository extends CrudRepository<TodoList, Long>, PagingAndSortingRepository<TodoList, Long> {

}
