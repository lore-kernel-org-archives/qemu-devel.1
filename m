Received: from eggs.gnu.org ([209.51.188.92]:36420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1H9-0004Qe-SQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB1H7-00032g-9D
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:03:15 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com
	([40.107.72.120]:20208
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB1H6-00031a-MY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:03:12 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 18:03:10 +0000
Message-ID: <CY4PR2201MB125450FAD705BA344A333FCCC6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1553845000-6537-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1553845000-6537-6-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/mips: Different approach
 toward INSERT MSA instr. and big endian fix
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
> Subject: [PATCH v3 5/5] target/mips: Different approach toward INSERT MSA=
 instr. and big endian fix

"Different approach toward..." -> "Refactor and fix INSERT.<B|H|W|D> instru=
ctions"=
