Received: from eggs.gnu.org ([209.51.188.92]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGrDD-0007WV-N8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGrDB-0001Yz-QC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:18 -0400
Received: from mail-eopbgr790127.outbound.protection.outlook.com
	([40.107.79.127]:30000
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGrDB-0001Tx-Bv
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:17 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Apr 2019 20:31:13 +0000
Message-ID: <BN6PR2201MB1251F5D12066080D6B6F940AC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 0/6] target/mips: Optimize MSA
 interleave instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "philmd@redhat.com" <philmd@redhat.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v7 0/6] target/mips: Optimize MSA interleave instructions
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Optimize and refactor MSA instructions ILVEV.<B|H|W|D>,
> ILVOD.<B|H|W|D>, ILVL.<B|H|W|D> and ILVR.<B|H|W|D>.

Patch number 5/6 seems to be for some reason lost. Please resend the
complete series.

Thanks,
Aleksandar
