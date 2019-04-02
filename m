Received: from eggs.gnu.org ([209.51.188.92]:58672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBPey-0004hj-DM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBPex-0004ou-3r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:05:28 -0400
Received: from mail-eopbgr820118.outbound.protection.outlook.com
	([40.107.82.118]:6377
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBPet-0004j6-Ep
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:05:25 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 20:05:19 +0000
Message-ID: <BN6PR2201MB12514F104F4AFE2D03767E31C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190327181650.23992-1-jbi.octave@gmail.com>
In-Reply-To: <20190327181650.23992-1-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: add * to comments and
 realign them to fix checkpatch warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH v2] target/mips: add * to comments and realign them to fi=
x checkpatch warnings
>=20
> Add * to comments and realign to fix warnings issued by checkpatch.pl too=
l
> "WARNING: Block comments use a leading /* on a separate line"
> within the file "target/mips/cp0_timer.c".
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Jules,

would you perhapsh like to clean up files cpu.h,  mips-defs.h, and trace.h =
in target/mips dir (from all checkpatch errors and warnings, if possible)? =
I wanted to do it for a long time.

Sincerelly,
Aleksandar
