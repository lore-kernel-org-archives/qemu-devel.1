Received: from eggs.gnu.org ([2001:4830:134:3::10]:46066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cRK8G-00065R-J8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cRK8C-0006OE-Gb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:44:08 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cRK8C-0006O5-B3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:44:04 -0500
Received: by mail-yb0-x244.google.com with SMTP id w194so56261ybe.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<87k2a1lkwg.fsf@dusky.pond.sub.org>
In-Reply-To: <87k2a1lkwg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Jan 2017 14:43:53 +0000
Message-ID: <CAJ+F1CK=QkzHb0OrhLTY37KT57wErkEr9pgQ4omxxPpNQw9d9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/21] qapi doc generation (whole
 version, squashed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Wed, Jan 11, 2017 at 3:41 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add a qapi2texi script to generate the documentation from the qapi
> > schemas.
> >
> > The SQUASHED patch in this series is a squashed version of the
> > documentation move from qmp-commands.txt to the schemas. The whole
> > version (not sent on the ML to avoid spamming) is in the following git
> > branch: https://github.com/elmarco/qemu/commits/qapi-doc
> >
> > PDF preview:
> > https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf (v7 without type
> info)
>
> PATCH 15 "qapi: add qapi2texi script" might need another respin,
> depending on discussion.  The rest looks ready to me, with a few commit
> message tweaks.
>
> I could take PATCH 01-08,11 right away if that helps.
>

That will certainly help if you could take patches (including the one with
minor nits if any), then I can rebase on top of your branch (qapi-next ?)
--=20
Marc-Andr=C3=A9 Lureau
