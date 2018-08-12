Received: from [2001:4830:134:3::10] (port=47966 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fotuc-0000Gw-6d
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fotuG-0003QF-Th
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:12:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fotuG-0003Py-IF
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:11:56 -0400
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-63-git-send-email-aleksandar.markovic@rt-rk.com>
	<BN7PR08MB4868618C0BD26540E737839AC63A0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <682260bc-a2bb-bfe5-f7e9-edc5fbc067c9@vivier.eu>
Date: Sun, 12 Aug 2018 18:23:42 +0200
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868618C0BD26540E737839AC63A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 62/80] linux-user: Add syscall numbers
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

Le 12/08/2018 à 17:44, Aleksandar Markovic a écrit :
> ping

Where can we find the kernel source for nanoMIPS to be able to compare
the QEMU syscall numbers definition?

Thanks,
Laurent
