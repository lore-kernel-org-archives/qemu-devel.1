Received: from eggs.gnu.org ([209.51.188.92]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqfI3-0000SN-Uj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqfI3-0003Bx-9t
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:32:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gqfI1-00038q-U2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:32:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id a16so84591wrv.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20190204095725.27259-1-marcandre.lureau@redhat.com>
	<874l9jpsbw.fsf@dusky.pond.sub.org>
In-Reply-To: <874l9jpsbw.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Feb 2019 15:31:47 +0100
Message-ID: <CAJ+F1CL0OqR3kcRStDcJP5SwTh_-_X4Rdenf08GNixAmOxetrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-gdb: add a QObject pretty printer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Mon, Feb 4, 2019 at 3:00 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Is your subject accurate?  To my (admittedly ignorant) eyes, the patch
> looks like an *Object* pretty-printer, not a *QObject* pretty-printer.
>

Yes Object, not QObject, sorry, the confusion will remain for a long time..

feel free to change commit message on commit,

thanks

--=20
Marc-Andr=C3=A9 Lureau
