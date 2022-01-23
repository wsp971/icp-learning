export const idlFactory = ({ IDL }) => {
  const FollowAuthor = IDL.Record({
    'id' : IDL.Principal,
    'name' : IDL.Opt(IDL.Text),
  });
  const Time = IDL.Int;
  const Message = IDL.Record({
    'content' : IDL.Text,
    'time' : Time,
    'author' : IDL.Text,
  });
  return IDL.Service({
    'follow' : IDL.Func([IDL.Principal], [], []),
    'follows' : IDL.Func([], [IDL.Vec(FollowAuthor)], []),
    'get_name' : IDL.Func([], [IDL.Text], ['query']),
    'post' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'posts' : IDL.Func([Time], [IDL.Vec(Message)], ['query']),
    'queryFollowsPosts' : IDL.Func(
        [IDL.Principal, Time],
        [IDL.Vec(Message)],
        [],
      ),
    'set_name' : IDL.Func([IDL.Text], [], []),
    'timeline' : IDL.Func([Time], [IDL.Vec(Message)], []),
    'unfollow' : IDL.Func([IDL.Principal], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
