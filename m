Received: from eggs.gnu.org ([2001:4830:134:3::10]:49346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgAC-00073O-7y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgAB-0000Fj-Co
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:36:24 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:33007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dVgAB-0000Et-35
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:36:23 -0400
Received: by mail-lf0-x231.google.com with SMTP id z78so39136598lff.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<20170711103011.32631-7-marcandre.lureau@redhat.com>
	<7a147bbd-04d1-be64-6479-990156596704@redhat.com>
	<CAJ+F1CK1EKBTUEbyaEHqje-S-R43rSD7cUQvsJQxEA-m=WnAUQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CK1EKBTUEbyaEHqje-S-R43rSD7cUQvsJQxEA-m=WnAUQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jul 2017 15:36:11 +0000
Message-ID: <CAJ+F1C+vErCmqwEgoJjzVYmxFpnOHh58eSaYExQmMgET5dse1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

Hi

On Wed, Jul 12, 2017 at 2:08 AM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Acked-by: Laszlo Ersek <lersek@redhat.com>
>
>>
>> but I would still like a real Pythonista to review this patch. Adding
>> Janosch.
>>
>>
> sure, let's wait for his feedback
>
>
> Janosch -- can you please help review this patch?
>
>
I am going to resend the series, it would be nice if we can make it before
the soft-freeze.

thanks
--=20
Marc-Andr=C3=A9 Lureau
