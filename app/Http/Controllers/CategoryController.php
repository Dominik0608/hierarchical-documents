<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use File;

use App\Models\Category;
use App\Models\Document;

class CategoryController extends Controller
{
  public function __construct() {
    $this->middleware('auth');
  }

  public function index() {
    $categories = Category::select(['id', 'name as text', 'parent'])
                            ->join('user_permissions', 'user_permissions.category', '=', 'categories.id')
                            ->where('user_permissions.userid', Auth::user()->id)
                            ->get();

    $documents = Document::select(['id', 'filename as text', 'documents.category as parent', 'hash'])
                            ->join('user_permissions', 'user_permissions.category', '=', 'documents.category')
                            ->where('user_permissions.userid', Auth::user()->id)
                            ->get();

    return view('categories/index', [
      'categories' => $categories,
      'documents' => $documents,
    ]);
  }

  public function fileUpload(Request $request) {
    $validator = $request->validate([
      'file' => 'required|file|max:2048',
      'category' => 'required',
    ]);

    $id = Auth::user()->id;
    if (!$id) {
      return redirect()->back()->withInput()->withErrors('Ismeretlen felhasználó.');
    }

    if ($request->file('file') != null) {
      $file = $request->file('file');
      $filename = $file->getClientOriginalName();
      $extension = $file->getClientOriginalExtension();
      $hash = hash('sha256', uniqid());
      $destinationPath = public_path(). '/uploads/files/' . $hash;

      if (!file_exists($destinationPath)) {
        $dir = File::makeDirectory('uploads/files/' . $hash, $mode = 0777, true);
      }

      try {
        $file->move($destinationPath, $filename);
      } catch (Exception $e) {
        return redirect()->back()->withInput()->withErrors('A fájl feltöltése sikertelen!');
      }

      $document = new Document;
      $document->filename = $filename;
      $document->user = $id;
      $document->category = $request->category;
      $document->hash = $hash;
      $document->save();
    }

    return redirect('/');
  }
}
