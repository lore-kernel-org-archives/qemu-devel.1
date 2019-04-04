Received: from eggs.gnu.org ([209.51.188.92]:41272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hC78S-0006ty-1V
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hC78Q-0000VP-SB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:30:48 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com
	([40.107.68.106]:23013
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hC78Q-0000UJ-LR
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:30:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 4 Apr 2019 18:30:44 +0000
Message-ID: <BN6PR2201MB1251F97F7A5B90E66EB3398CC6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190404173921.30841-1-jbi.octave@gmail.com>,
	<20190404173921.30841-3-jbi.octave@gmail.com>
In-Reply-To: <20190404173921.30841-3-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/mips: add or remove space to
 fix checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH v2 2/2] target/mips: add or remove space to fix checkpatc=
h errors
>=20
> Add or remove space to fix errors issued by checkpatch.pl tool
> "ERROR: spaces required around ..."
> "ERROR: space required after that"
> "ERROR: space required before the open parenthesis"
> "ERROR: space prohibited between function name and open parenthesis"
> within "target/mips/cpu.h" file.
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

This patch should also contain the fix for long lines, otherwise the
checkpatch.pl complains about this very patch.

In any case, thank you for sending this and other patches!

Aleksandar=
