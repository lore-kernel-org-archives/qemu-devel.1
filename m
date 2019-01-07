Received: from eggs.gnu.org ([209.51.188.92]:56155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ggP6A-0007Lc-0I
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ggP63-0003mc-EB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:13:17 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:49763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ggP5z-0003ie-Lb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:13:13 -0500
References: <b95d4a9c-4bee-5e0d-5ec6-02edf3aefcc1@vivier.eu>
	<20181214154130.4069-1-tom.deseyn@gmail.com>
	<CAErTmiPDhaLR8YZbABtZ=BAquXC0ZW=Y+tBRZr4YtRas0UpiLQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <199d2900-1f2c-4940-ae2a-d6832501f1f0@vivier.eu>
Date: Mon, 7 Jan 2019 08:12:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAErTmiPDhaLR8YZbABtZ=BAquXC0ZW=Y+tBRZr4YtRas0UpiLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] Add getsockopt for settable SOL_IPV6
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tom Deseyn <tom.deseyn@gmail.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

Le 07/01/2019 à 06:50, Tom Deseyn a écrit :
> Hi Laurent,
> 
> Can you please take a look at the updated patch? Should I add braces for
> code-style?

Yes, new code must follow code-style. Older is only updated when we
modify it for something else.

Thanks,
Laurent
