Received: from eggs.gnu.org ([209.51.188.92]:33815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgd5-00076F-2o
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBgd4-0006WY-6W
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:12:39 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com
	([40.107.68.113]:23013
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBgd3-0006Vs-VM
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:12:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 14:12:35 +0000
Message-ID: <BN6PR2201MB12518C40A274232C860BBBC3C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190403125055.26564-1-jbi.octave@gmail.com>,
	<20190403125055.26564-4-jbi.octave@gmail.com>
In-Reply-To: <20190403125055.26564-4-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/5] target/mips: replace indentation with
 space to fix checkpatch errors
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
> Subject: [PATCH 3/5] target/mips: replace indentation with space to fix c=
heckpatch errors
>
> Replace indentation with space to fix errors issued by checkpatch.pl tool
> "ERROR: code indent should never use tabs"
> within "target/mips/cpu.h" file.
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

This patch is fine.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
