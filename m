Received: from eggs.gnu.org ([2001:4830:134:3::10]:46277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g6zK3-0007xv-4s
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g6zJz-0004QO-B6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g6zJy-0004Q9-Dt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:37:15 -0400
References: <20180930195655.24684-1-f4bug@amsat.org>
	<20180930195655.24684-5-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6112c155-4036-0f80-8ebf-b6ddef32d0b9@redhat.com>
Date: Mon, 1 Oct 2018 09:37:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180930195655.24684-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] MAINTAINERS: Voluntary to review
 hobbyist MIPS contributions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org

On 9/30/18 2:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

In the subject line,
s/Voluntary/Volunteer/

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce7c351afa..2708745bf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -188,6 +188,7 @@ F: disas/microblaze.c
>   MIPS
>   M: Aurelien Jarno <aurelien@aurel32.net>
>   M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>   S: Maintained
>   F: target/mips/
>   F: hw/mips/
> @@ -1948,6 +1949,7 @@ F: disas/i386.c
>  =20
>   MIPS target
>   M: Aurelien Jarno <aurelien@aurel32.net>
> +R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>   S: Maintained
>   F: tcg/mips/
>   F: disas/mips.c
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
