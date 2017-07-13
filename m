Received: from eggs.gnu.org ([2001:4830:134:3::10]:40341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVjlQ-00011p-Hb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVjlN-00084s-FA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dVjlN-00084O-8Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:27:01 -0400
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<20170711103011.32631-7-marcandre.lureau@redhat.com>
	<7a147bbd-04d1-be64-6479-990156596704@redhat.com>
	<CAJ+F1CK1EKBTUEbyaEHqje-S-R43rSD7cUQvsJQxEA-m=WnAUQ@mail.gmail.com>
	<CAJ+F1C+vErCmqwEgoJjzVYmxFpnOHh58eSaYExQmMgET5dse1Q@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <72dd73d0-cc42-9ddd-db88-2b02f8b2c0e3@redhat.com>
Date: Thu, 13 Jul 2017 21:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+vErCmqwEgoJjzVYmxFpnOHh58eSaYExQmMgET5dse1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On 07/13/17 17:36, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 12, 2017 at 2:08 AM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@gmail.com> wrote:
>=20
>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>
>>>
>>> but I would still like a real Pythonista to review this patch. Adding
>>> Janosch.
>>>
>>>
>> sure, let's wait for his feedback
>>
>>
>> Janosch -- can you please help review this patch?
>>
>>
> I am going to resend the series, it would be nice if we can make it bef=
ore
> the soft-freeze.

Well if noone with better Python than mine steps up to review the python
changes, I say we go ahead with them using my Acked-by.

Thanks
Laszlo
