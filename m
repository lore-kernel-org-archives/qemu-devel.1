Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkb8-00036K-Jb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkb2-00052y-FB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:06:45 -0400
Received: from mail-by2nam01on0121.outbound.protection.outlook.com
	([104.47.34.121]:46880
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCkb0-0004pW-Sm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:06:39 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Oct 2018 12:06:29 +0000
Message-ID: <BN6PR2201MB1251EF12E370B0D64CF32928C6FF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20180930214744.27580-1-f4bug@amsat.org>,
	<20180930214744.27580-4-f4bug@amsat.org>
In-Reply-To: <20180930214744.27580-4-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/mips: Clean the 'insn_flags'
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Subject: [PATCH v3 3/4] target/mips: Clean the 'insn_flags' namespace
>
> Let space available for the ASE_DSPR3 entry.
>=20
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch will be included in the next MIPS queue with minor modifications=
.=
