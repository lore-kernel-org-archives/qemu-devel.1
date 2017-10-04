Received: from eggs.gnu.org ([2001:4830:134:3::10]:33851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzkMb-0005hN-Si
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzkMb-0007Kt-2g
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzkMa-0007KP-Tg
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:28 -0400
Received: by mail-oi0-x243.google.com with SMTP id w197so15107054oif.6
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 07:09:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877ewbm5eg.fsf@dusky.pond.sub.org>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-2-armbru@redhat.com>
	<CAJ+F1CL0Nfy-bjsz0XW1HhfqphUB5BdyyroiRweWfFsXDJVmOA@mail.gmail.com>
	<877ewbm5eg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 16:09:26 +0200
Message-ID: <CAJ+F1CJKetzGqvngdyxc6R_SXtKAFQMZ3ABj8J7vLs09+CT_JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] qapi-schema: Fix
 query-vm-generation-id's doc comment markup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Oct 4, 2017 at 3:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> Reported-by: Daniel P. Berrange <berrange@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks!
>
>> (reviweing this patch makes me realize that the last
>> expression/command in qapi-schema isn't in the generated doc..)
>
> Oh.  We better fix that.

Ah no, it's because I had an old docs/qemu-qmp-qapi.texi in my build tree..=
.



--=20
Marc-Andr=C3=A9 Lureau
