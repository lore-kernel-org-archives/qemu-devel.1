Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVafE-0000j0-So
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaf3-0005f3-2I
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaf2-0005eG-Dp
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so3963206qkh.11
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-16-marcandre.lureau@redhat.com>
	<87lg53olyf.fsf@dusky.pond.sub.org>
In-Reply-To: <87lg53olyf.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:20:18 +0400
Message-ID: <CAMxuvaxENFTV9SV0jF9Q9qcf2p5vAdPZ5t8BumQLVXvqP9knrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/27] qapi: rename allow_dict to
 allow_implicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Dec 5, 2018 at 10:41 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > This makes it a bit clearer what is the intent of the dictionnary for
>
> dictionary

sigh, this must be a very common misspell (dictionnaire in french)

>
> > the check_type() function, since there was some confusion on a
> > previous iteration of this series.
>
> I don't remember... got a pointer to that confusion handy?

https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01584.html

>
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
