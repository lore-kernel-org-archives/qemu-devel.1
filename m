Received: from eggs.gnu.org ([2001:4830:134:3::10]:50291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJTN-0008LN-GJ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJTM-0004Zt-Nv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:11:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gWJTL-0004Y5-I1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:11:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id v13so10036264wrw.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-8-marcandre.lureau@redhat.com>
	<87va41k8bd.fsf@dusky.pond.sub.org>
In-Reply-To: <87va41k8bd.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Dec 2018 15:11:20 +0400
Message-ID: <CAJ+F1CLeooF2ynfYSB1q_tTyqEsLcThR9Guv-AvX9tb+bQmRZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 07/27] qapi: improve reporting
 of unknown or missing keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Dec 10, 2018 at 2:03 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Report the set of missing or unknown keys. And give a hint about the
> > accepted keys.
>
> Suggest to add:
>
>   The error message for multiple meta type members (visible in
>   tests/qapi-schema/double-type.err) is not improved.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

ack, thanks

--=20
Marc-Andr=C3=A9 Lureau
