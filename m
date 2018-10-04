Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86sL-0006zH-Cb
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86sK-0007PC-Ir
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:53:21 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-2-crosa@redhat.com>
	<5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0a405ae6-d69a-8e04-e3dc-3b7883447248@redhat.com>
Date: Thu, 4 Oct 2018 12:53:09 -0400
MIME-Version: 1.0
In-Reply-To: <5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-img.c: comment typo fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>



On 10/4/18 12:48 PM, Eric Blake wrote:
> On 10/4/18 11:18 AM, Cleber Rosa wrote:
>> A trivial comment typo fix.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 qemu-img.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b12f4cd19b..a96b76c187 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1085,7 +1085,7 @@ static int64_t find_nonzero(const uint8_t *buf,
>> int64_t n)
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> - * Returns true iff the first sector pointed to by 'buf' contains at
>> least
>> + * Returns true if the first sector pointed to by 'buf' contains at
>> least
>=20
> NACK.=C2=A0 You're not the first person to propose this change.=C2=A0 H=
owever,
> "iff" is an English word (albeit archaic) which is shorthand for "if an=
d
> only if", which has a distinct logical meaning separate from the weaker
> "if".=C2=A0 Spelling it out in longhand instead of calling it a typo is
> probably acceptable, though.
>=20

Wow, thanks for the explanation.  I agree that spelling it out is a good
option, as it'll probably prevent other people from falling into the
same "language trap" as I did.

Thanks!
- Cleber.
