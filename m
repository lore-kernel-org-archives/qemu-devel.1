Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ew2Uq-0003iI-Iv
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ew2Ul-0002S9-HZ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:14:56 -0400
Received: from [162.105.89.7] (port=59043 helo=mprc.pku.edu.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gxt@mprc.pku.edu.cn>) id 1ew2Uk-0002Q1-EW
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:14:51 -0400
Message-ID: <51404.203.187.182.140.1521018597.squirrel@mprc.pku.edu.cn>
In-Reply-To: <CAFEAcA-JwWcB42CbL0rmZVYj06L+jT4BoK4tDaYmEprfcezNFg@mail.gmail.com>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
	<08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
	<CAFEAcA-JwWcB42CbL0rmZVYj06L+jT4BoK4tDaYmEprfcezNFg@mail.gmail.com>
Date: Wed, 14 Mar 2018 17:09:57 +0800 (CST)
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alex =?gb2312?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>


> [...]
> Personally, I think it's useful to consider not merely "do we
> have anybody actively maintaining this" (after all our x86 frontend
> is not exactly very well-loved!) but also "are there users of QEMU
> out there using it?" and "is this actually something that exists
> in the real world as actual silicon in any quantity?". I think
> unicore32 failed on both of those, but tilegx passes the latter
> and possibly the former.
>
> thanks
> -- PMM
>

UniCore is a real silicon product, integrated into PKUnity SoC, and sold
in a large amount of embedded boxes, such as cloud terminals and set top
boxes. Since we provide complete product solutions, few users use QEmu
directly to simulate the booting and running of unicore32-linux runtime
system.
For me, I still maintain unicore32 port, and I really appreciate having
unicore32 port in the tree.

Thanks

Guan Xuetao
