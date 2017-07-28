Received: from eggs.gnu.org ([2001:4830:134:3::10]:52170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dbBxu-0000em-M2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dbBxt-0007qv-Qi
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:34:30 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-39-f4bug@amsat.org>
	<20170728061620.GO5117@lemon.lan>
From: John Snow <jsnow@redhat.com>
Message-ID: <ba9d2082-62a8-1c29-f5bb-0ac47d857e5e@redhat.com>
Date: Fri, 28 Jul 2017 16:34:15 -0400
MIME-Version: 1.0
In-Reply-To: <20170728061620.GO5117@lemon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 38/47] MAINTAINERS: update docs/interop/
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 07/28/2017 02:16 AM, Fam Zheng wrote:
> On Fri, 07/28 02:36, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23de632424..54e35fdab9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1283,7 +1283,7 @@ F: block/dirty-bitmap.c
>>   F: include/qemu/hbitmap.h
>>   F: include/block/dirty-bitmap.h
>>   F: tests/test-hbitmap.c
>> -F: docs/bitmaps.md
>> +F: docs/interop/bitmaps.rst
>>   T: git git://github.com/famz/qemu.git bitmaps
>>   T: git git://github.com/jnsnow/qemu.git bitmaps
>>  =20
>> @@ -1852,7 +1852,7 @@ M: Denis V. Lunev <den@openvz.org>
>>   L: qemu-block@nongnu.org
>>   S: Supported
>>   F: block/parallels.c
>> -F: docs/specs/parallels.txt
>> +F: docs/interop/parallels.txt
>>  =20
>>   qed
>>   M: Stefan Hajnoczi <stefanha@redhat.com>
>> --=20
>> 2.13.3
>>
>=20
> Acked-by: Fam Zheng <famz@redhat.com>
>=20

"Me too"

Acked-by: John Snow <jsnow@redhat.com>
