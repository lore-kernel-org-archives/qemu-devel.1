Received: from eggs.gnu.org ([2001:4830:134:3::10]:50295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fz4Ny-0000tr-HS
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 14:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fz4Nu-0007DY-Fp
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 14:24:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <817e08da-e255-7d1f-4668-503bd3c009d1@weilnetz.de>
Date: Sun, 9 Sep 2018 14:24:31 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <2DD892A7-1C5C-452E-9D5D-4FEABB5CB48B@gmail.com>
References: <20180909153238.4046-1-programmingkidx@gmail.com>
	<817e08da-e255-7d1f-4668-503bd3c009d1@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: update copyright date to
 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>


> On Sep 9, 2018, at 1:34 PM, Stefan Weil <sw@weilnetz.de> wrote:
>=20
> Am 09.09.2018 um 17:32 schrieb John Arbuckle:
>> Currently the copyright date is set to 2017. Update the date to say
>> 2018.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> include/qemu-common.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/include/qemu-common.h b/include/qemu-common.h
>> index 85f4749aef..ed60ba251d 100644
>> --- a/include/qemu-common.h
>> +++ b/include/qemu-common.h
>> @@ -17,7 +17,7 @@
>> #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D=
 EINTR)
>>=20
>> /* Copyright string for -version arguments, About dialogs, etc */
>> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
>> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
>>     "Fabrice Bellard and the QEMU Project developers"
>>=20
>> /* Bug reporting information for --help arguments, About dialogs, etc =
*/
>>=20
>=20
>=20
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>=20
> I think this is trivial enough for qemu-trivial.
>=20
> Thanks,
> Stefan

Thank you for reviewing my patch. Yeah it probably should be considered =
trivial.=
