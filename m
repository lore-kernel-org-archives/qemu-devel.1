Received: from eggs.gnu.org ([2001:4830:134:3::10]:57903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWkai-0004nQ-Vv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWkag-00036N-D8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:09:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gWkag-00034u-8D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:08:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so16981347qtl.5
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-26-marcandre.lureau@redhat.com>
	<87woognj2k.fsf@dusky.pond.sub.org>
In-Reply-To: <87woognj2k.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 20:08:43 +0400
Message-ID: <CAMxuvayGNWF3JEbRsvAKZzgzK9zJt_1NYr+8EQkeJ0+G84h=gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 25/27] qapi: break long lines at
 'data' member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>, stefanb@linux.ibm.com

Hi

On Tue, Dec 11, 2018 at 8:07 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Let's break the line before 'data'. While at it, improve a bit
> > indentation/spacing. (I removed some alignment which are not helping
> > much readability and become quickly inconsistent)
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I can cherry-pick this one into my next pull request to reduce the
> likelihood of conflicts.

Ideally, you take as much patches as you can in your -next tree, so I
don't have to carry them and resend them all the time. Up to you, you
are the maintainer.
