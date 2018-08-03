Received: from eggs.gnu.org ([2001:4830:134:3::10]:37386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1flYiP-0000Ee-D8
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1flYiK-0005D3-Fj
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:57:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1flYiK-0005Bl-4h
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:57:48 -0400
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-78-git-send-email-stefan.markovic@rt-rk.com>
	<0a43387a-f475-874d-2846-46ce38d9d812@vivier.eu>
	<CY4PR08MB2486543AECEBFAEE4D608EF1D2230@CY4PR08MB2486.namprd08.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3da517d7-dfff-5c61-5c38-7d11710fd665@vivier.eu>
Date: Fri, 3 Aug 2018 13:57:07 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR08MB2486543AECEBFAEE4D608EF1D2230@CY4PR08MB2486.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 77/77] linux-user: Add nanoMIPS support
 in scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Le 03/08/2018 à 13:23, Aleksandar Rikalo a écrit :
> Hi, Laurent,
> 
> Thank You for the explanation.
> 
> We will correct this in the next version.
> We will also fix family values for the regular mips architectures in
> separate patch.

It's a good idea.

Thanks,
Laurent
