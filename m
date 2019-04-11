Received: from eggs.gnu.org ([209.51.188.92]:37354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hEg0a-0001pj-9k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hEg0Y-00059d-NW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:16 -0400
Received: from mail-eopbgr770103.outbound.protection.outlook.com
	([40.107.77.103]:61644
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hEg0Y-00058B-Ao
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:14 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 11 Apr 2019 20:09:09 +0000
Message-ID: <BN6PR2201MB125112CE3BBE8E7DCA624750C62F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>,
	<20190405160938.27494-3-jbi.octave@gmail.com>
In-Reply-To: <20190405160938.27494-3-jbi.octave@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/mips: add or remove space to
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
> Subject: [PATCH v3 2/4] target/mips: add or remove space to fix checkpatc=
h errors
>
> Add or remove space to fix errors issued by checkpatch.pl tool
> "ERROR: spaces required around ..."
> "ERROR: space required after that"
> "ERROR: space required before the open parenthesis"
> "ERROR: space prohibited between function name and open parenthesis"
> within "target/mips/cpu.h" file.
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

Hi, Jules,

I think if you merge this patch (2/4) and the next one (3/4), your series w=
ould be good to go.

Sincerely,
Aleksandar
