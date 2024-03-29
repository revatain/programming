<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script
      type="text/javascript"
      src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"
    ></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <link
      href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
      rel="stylesheet"
      id="bootstrap-css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/todoList.css"
    />
    <title>todoList</title>
  </head>
  <body>
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">
            <span id="userId"></span>'s work
          </a>
        </div>
        <button
          type="button"
          onclick="javascript:location.replace('/logout')"
          class="btn btn-default navbar-btn navbar-right"
        >
          logout
        </button>
      </div>
    </nav>
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div class="todolist not-done">
            <h1>TODO LIST</h1>
            <input
              id="content"
              type="text"
              class="form-control add-todo"
              placeholder="할일을 입력하고 엔터를 치세요"
              autofocus
            />
            <hr />
            <ul id="sortable" class="list-unstyled"></ul>
            <div class="todo-footer">
              <strong>
                <span id="countTodos" class="count-todos"></span>
              </strong>
              항목 남았음
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="todolist">
            <h1>Already DONE</h1>
            <ul id="done-items" class="list-unstyled"></ul>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script>
    console.log("스타일 참고", "https://bootsnipp.com/snippets/QbN51");

    // get
    const init = () => {
      fetch("/api/v3/todo", {
        method: "GET",
      })
        .then((res) => res.json())
        .then((result) => {
          console.log(result);

          const userId = result.data.user.id;
          const todoList = result.data.todoList.filter(
            (todo) => todo.doneYn == "N"
          );
          const todoCount = todoList.length;
          const doneList = result.data.todoList.filter(
            (todo) => todo.doneYn == "Y"
          );

          document.querySelector("#userId").innerHTML = userId;

          // 원래 리스트 요소 삭제
          const todoListEl = document.querySelector("#sortable");
          // contentEl.innerHTML = "";
          while (todoListEl.hasChildNodes()) {
            todoListEl.removeChild(todoListEl.lastChild);
          }

          // 새 리스트 요소 추가
          for (const todo of todoList) {
            todoListEl.insertAdjacentHTML(
              "beforeend",
              `
        <li class="ui-state-default">
          <div class="checkbox">
            <label>
              <input onchange="setDone(` +
                todo.idx +
                `)" type="checkbox" value="" />
              <span>` +
                todo.content +
                `</span>
            </label>
          </div>
        </li>
        `
            );
          }

          document.querySelector("#countTodos").innerHTML = todoCount;

          const doneListEl = document.querySelector("#done-items");

          doneListEl.innerHTML = "";

          for (const todo of doneList) {
            doneListEl.insertAdjacentHTML(
              "beforeend",
              `
        <li>
          <div class="checkbox">
            <label>
              <input
                onchange="setDone(` +
                todo.idx +
                `)"
                class="remove-item"
                type="checkbox"
                value=""
              />
              <span>` +
                todo.content +
                `</span>
            </label>
            <button
              onclick="setDelete(` +
                todo.idx +
                `)"
              class="remove-item btn btn-default btn-xs pull-right"
            >
              <span class="glyphicon glyphicon-remove"></span>
            </button>
          </div>
        </li>
        `
            );
          }
        })
        .catch((error) => {
          console.log(error);
          alert("에러가 발생했습니다.");
        });
    };

    init();

    // 할일 입력하고 엔터치면 등록
    const contentInput = document.getElementById("content");
    contentInput.addEventListener("keyup", (e) => {
      if (e.keyCode === 13) {
        // 내용이 없으면 함수 종료
        if (contentInput.value === "") {
          alert("내용을 입력해 주세요.");
          contentInput.focus();
          return;
        }

        // ReqBasic 객체와 동일한 형태로 객체 생성
        const data = {
          content: contentInput.value,
        };

        fetch("/api/v3/todo", {
          method: "POST",
          headers: {
            "Content-Type": "application/json;charset=utf-8",
          },
          body: JSON.stringify(data),
        })
          .then((res) => res.json())
          .then((result) => {
            init();
            document.querySelector("#content").value = "";
          })
          .catch((error) => {
            alert("에러가 발생했습니다.");
          });
      }
    });

    const setDone = (idx) => {
      fetch("/api/v3/todo/" + idx, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json;charset=utf-8",
        },
      })
        .then((res) => res.json())
        .then((result) => {
          init();
        })
        .catch((error) => {
          alert("에러가 발생했습니다.");
        });
    };

    const setDelete = (idx) => {
      fetch("/api/v3/todo/" + idx, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json;charset=utf-8",
        },
      })
        .then((res) => res.json())
        .then((result) => {
          init();
        })
        .catch((error) => {
          alert("에러가 발생했습니다.");
        });
    };

  </script>
</html>
