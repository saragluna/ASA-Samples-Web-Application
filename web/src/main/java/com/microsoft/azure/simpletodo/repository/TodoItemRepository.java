package com.microsoft.azure.simpletodo.repository;

import com.microsoft.azure.simpletodo.model.TodoItem;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TodoItemRepository extends CrudRepository<TodoItem, Long> {

    List<TodoItem> findByListId(Long listId);

    List<TodoItem> findByListId(Long listId, Pageable pageable);

    List<TodoItem> findByListIdAndState(Long listId, String state, Pageable pageable);
}
