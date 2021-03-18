# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Forum.Repo.insert!(%Forum.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Forum.{Repo, Thread, Comment}

Repo.insert!(%Thread{
  title: "Which came first?  The egg or the chicken?",
  description: "It is a sincere question",
  username: "teijiw",
  comments: [
    Repo.insert!(%Comment{
      message: "I think the chicken came first",
      username: "john_doe_2011"
    }),
    Repo.insert!(%Comment{
      message: "I really don't know man.",
      username: "anon_21325"
    })
  ]
})

Repo.insert!(%Thread{
  title: "Java and Javascript",
  description: "What's the difference between Java and Javascript?",
  username: "jack_99",
  comments: [
    Repo.insert!(%Comment{
      message: "Yes.",
      username: "bob_92"
    })
  ]
})

Repo.insert!(%Thread{
  title: "Lorem Ipsum",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed iaculis, nisl at semper porttitor, diam turpis pharetra tortor, et interdum felis quam vitae leo. Nulla facilisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam lobortis nisl sapien, nec laoreet sem laoreet vitae. Nulla facilisi. In at interdum justo. Suspendisse tincidunt molestie nunc, a tincidunt risus porttitor id. Morbi lacinia et enim sit amet malesuada. Quisque pellentesque non arcu nec vulputate. Aliquam pharetra dui eu aliquam venenatis. Curabitur nec vulputate turpis, id viverra eros. Cras a faucibus eros. Phasellus tempor enim a ipsum hendrerit aliquet. Curabitur varius sapien quis odio sodales accumsan ut nec est. Integer quis lorem et elit malesuada accumsan.

Proin nec est et velit pulvinar egestas non tincidunt urna. Praesent elit ligula, sollicitudin ac lectus eget, tempus rhoncus metus. Proin rutrum lorem vitae justo tristique ornare. Sed at consectetur nisi, vitae cursus mi. Pellentesque lacinia felis consequat imperdiet ornare. Ut dignissim rutrum mollis. Praesent eget euismod tortor, eget mollis diam.

Donec congue turpis a lectus feugiat elementum. Nullam erat nulla, ultricies eget molestie quis, congue sit amet velit. Suspendisse sit amet augue consequat, egestas sapien in, euismod lorem. Mauris bibendum, turpis in euismod dapibus, neque arcu tincidunt eros, et iaculis mi ante quis erat. Suspendisse tempor arcu massa, eu ultricies ligula consequat vel. In nec eleifend ipsum, non egestas neque. Vivamus nisi lorem, volutpat sed tempus ac, mollis ac sem. Duis pellentesque est id ultrices sodales. Sed imperdiet urna nec tortor sollicitudin, ut facilisis est lobortis. Cras quis ligula tortor. Nam vel nisi hendrerit, condimentum nunc at, aliquet mi. Sed volutpat ligula at magna faucibus, quis placerat nulla commodo. Duis id velit lacinia, ultrices erat sit amet, faucibus ipsum. Suspendisse interdum ut leo eget porta. Donec id ligula eget eros blandit suscipit. Sed placerat diam non dolor ullamcorper, vel maximus justo consequat.

Proin tempor nec urna sed pharetra. Nullam ornare lacus sit amet molestie laoreet. Curabitur sapien sapien, blandit sit amet porttitor bibendum, ornare et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum, urna quis sodales lobortis, tellus metus feugiat risus, id condimentum mi metus ac ligula. Etiam libero neque, fermentum imperdiet dignissim et, ornare ut magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum dignissim tellus, at mattis nulla lobortis eu. Aliquam erat volutpat.

Vestibulum quis nisl in lacus rhoncus tempus. Mauris fermentum nisl a sem commodo egestas. Integer ullamcorper ac urna ac tristique. Nulla lobortis sagittis mattis. Curabitur sit amet justo sit amet orci pulvinar tempor. Vivamus lorem leo, consectetur consectetur ante vel, maximus pellentesque odio. Ut dui sapien, iaculis ut ligula quis, consectetur malesuada arcu. Sed pulvinar quam tempor diam tristique, eu venenatis justo porttitor. Morbi dignissim mollis mauris vel malesuada. Nam sed diam et sem gravida fringilla ac at turpis. Etiam eros orci, commodo varius lacus id, condimentum fringilla sapien. Morbi venenatis gravida est ac semper. Donec condimentum, massa efficitur gravida dictum, tortor leo ultrices purus, vel pulvinar risus mauris non tortor.",
  username: "lorem",
  comments: [
    Repo.insert!(%Comment{
      message: "Obviously this text could not be missing",
      username: "teijiw"
    })
  ]
})
