Received: from eggs.gnu.org ([209.51.188.92]:37036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBQCF-0006wX-Nl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBQCD-0003Yv-Hr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:39:51 -0400
Received: from mail-eopbgr820097.outbound.protection.outlook.com
	([40.107.82.97]:53190
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBQC9-0003UI-SY
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:39:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 20:39:40 +0000
Message-ID: <BN6PR2201MB1251B47F3BDC8E89C016CE46C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554212605-16457-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/mips: Fix MSA instructions
 ST.<B|H|W|D> on big endian host
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
> Subject: [PATCH v4 2/5] target/mips: Fix MSA instructions ST.<B|H|W|D> on=
 big endian host
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Fix the case when the host is a big endian machine, and change
> the approach toward ST.<B|H|W|D> instruction helpers.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
