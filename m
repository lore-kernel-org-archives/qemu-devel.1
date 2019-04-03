Received: from eggs.gnu.org ([209.51.188.92]:35503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgjf-0001Cy-6w
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgje-0000Vy-7W
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:19:27 -0400
Received: from mail-eopbgr750121.outbound.protection.outlook.com
	([40.107.75.121]:36235
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBgjd-0000V9-TB
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:19:26 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 14:19:22 +0000
Message-ID: <BN6PR2201MB1251ABB890D691DBCDA3E5D6C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190403125055.26564-1-jbi.octave@gmail.com>
In-Reply-To: <20190403125055.26564-1-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] target/mips/cpu: errors and warnings
 coding style cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH 0/5] target/mips/cpu: errors and warnings coding style cl=
eanup
>
> This v1 series cleans up all warnings and errors of coding style within c=
pu.h
> file
>

Hi, Jules!

There are a couple of minor problems that I described in my comments
to other patches. Otherwise I like the series.

May I ask you to send v2 of the series, with some needed modifications?

Regards,
Aleksandar

> Jules Irenge (5):
>   target/mips: add space to fix checkpatch errors
>   target/mips: realign comments to fix checkpatch warnings
>   target/mips: replace indentation with space to fix checkpatch errors
>   target/mips: remove space to fix checkpatch errors
>   target/mips: wrap line into multiple lines to to fix checkpatch errors
>=20
>  target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
>  1 file changed, 117 insertions(+), 94 deletions(-)
