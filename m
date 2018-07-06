Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSzP-0001td-Pi
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSzM-0007bY-Ic
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:49:43 -0400
Received: from mail-by2nam05on071e.outbound.protection.outlook.com
	([2a01:111:f400:fe52::71e]:6144
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbSzM-0007bD-5N
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:49:40 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 15:49:21 +0000
Message-ID: <BN7PR08MB4868C170426CD454B5AE8871C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530728238-5608-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1530728238-5608-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530728238-5608-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] target/mips: Check ELPA flag only
 in some cases of MFHC0 and MTHC0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
> and placing ELPA flag checks befor switch statement were technically

befor -> before

this will be fixed in v5
