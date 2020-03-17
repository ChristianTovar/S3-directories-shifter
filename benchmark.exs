route = "res/pxd/image/upload/a05w2tpftkcj794lraah/1536767579.jpg"

single_transaction = fn route ->
  DirectoryShifter.Core.Aws.move_image(route)
  DirectoryShifter.Core.Aws.delete_object(route)
end

Benchee.run(
  %{
    "single_transaction" => fn -> single_transaction.(route) end
  }
)
