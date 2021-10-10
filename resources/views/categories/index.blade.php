@extends('layouts.app')

@section('content')
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-8">

      @error('category')
        <div class="alert alert-danger" role="alert">  
          {{ $message }}
        </div>
      @enderror

      @error('file')
        <div class="alert alert-danger" role="alert">  
          {{ $message }}
        </div>
      @enderror

      @foreach($errors->all() as $error)
        <div class="alert alert-danger" role="alert">  
          {{ $error }}
        </div>
      @endforeach

      <div id="category-tree"></div>
      <form id="upload-form" method="POST" class="mt-3" style="display: none;" enctype="multipart/form-data">
        @csrf
        <input id="category" type="hidden" name="category" required>
        <div class="form-group row">
          <div class="col-sm-12">
            <input id="file" type="file" name="file" class="form-control" required>
          </div>
        </div>

        <div class="form-group row mb-0">
          <div class="col-sm-12 text-center">
            <button type="submit" class="btn btn-primary">
              Feltöltés
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    let categories = @json($categories);
    var i = categories.length;
    while (i--) {
      if (categories[i].parent === null) {
        categories[i].parent = '#';
      } else {
        // ha egy kategóriának nincs szülője, akkor törölni kell a listából, különben hibára fut a jsTree és nem tölt be
        let parentExist = false;
        for(var j = 0; j < categories.length; j++) {
          if (categories[i].parent === categories[j].id) {
            parentExist = true;
            break;
          }
        }
        if (!parentExist) {
          categories.splice(i, 1);
          continue;
        }
      }
      categories[i].state = {opened: true};
    }

    let documents = @json($documents);
    var i = documents.length;
    while (i--) {
      // szintén ellenőrizni kell, hogy a dokumentumnak van-e szülője (kategóriája)
      let parentExist = false;
      for(var j = 0; j < categories.length; j++) {
        if (documents[i].parent === categories[j].id) {
          parentExist = true;
          break;
        }
      }
      if (!parentExist) {
        documents.splice(i, 1);
        continue;
      }
      documents[i].id = 'file_' + documents[i].id;
      documents[i].icon = 'jstree-file';
      documents[i].data = 'file';
    }

    $('#category-tree')
    .on('changed.jstree', function (e, data) {
      if (data?.node?.data === 'file') {
        $('#upload-form').hide();
        // kattintás esetén letöltés
        var a = document.createElement("a");
        a.href = '/uploads/files/' + data.node.original.hash + '/' + data.node.original.text;
        a.setAttribute("download", data.node.original.text);
        a.click();
      } else {
        $('#category').val(data.selected[0]);
        $('#upload-form').show();
      }
    })
    .jstree({ 'core' : {
      'multiple' : false,
      'data' : categories.concat(documents)
    } });
  });
</script>

<script>

</script>
@endsection