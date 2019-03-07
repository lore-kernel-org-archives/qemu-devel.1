Received: from eggs.gnu.org ([209.51.188.92]:40175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h1vHL-0007Bw-H4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h1vHK-0008Dq-5U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:49:51 -0500
Received: from mail-eopbgr770135.outbound.protection.outlook.com
	([40.107.77.135]:5063
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h1vHJ-0008D8-Q1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:49:50 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 7 Mar 2019 15:49:45 +0000
Message-ID: <BN6PR2201MB1251F6E7D424C96970DAEC62C64C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551964929-17845-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551964929-17845-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] target/mips: Add tests for a variety
 of MSA int binary ops
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
> Subject: [PATCH 0/5] target/mips: Add tests for a variety of MSA int bina=
ry ops
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> These are regression tests for MSA integer binary operations.

Some minor cleanups are needed in preambles and commit messages, but
nevertheless:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
