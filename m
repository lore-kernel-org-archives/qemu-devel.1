Received: from eggs.gnu.org ([209.51.188.92]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1CY-0000wf-Qa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1CX-0001MU-Ss
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:58:30 -0400
Received: from mail-eopbgr750113.outbound.protection.outlook.com
	([40.107.75.113]:18503
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB1CX-0001MB-Lr
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:58:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:58:27 +0000
Message-ID: <CY4PR2201MB1254FCEE59DB7763A7E71EFAC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1553845000-6537-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1553845000-6537-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/mips: MSA instructions st,
 big endian host fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v3 2/5] target/mips: MSA instructions st, big endian host=
 fix
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Fix the case when the host is running on a big endian machine,
> and change the approach toward st instruction helpers.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

The same comment as in the patch 1/5.

Also, please align both equation signs and argument indexes in the
new bodies of the helpers.

Thanks,
Aleksandar
