Received: from eggs.gnu.org ([2001:4830:134:3::10]:42501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMDUB-0005zX-7k
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMDU8-0001zb-FL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:43 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMDU8-0001zA-5h
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:40 -0500
References: <20181019174958.26616-1-peter.maydell@linaro.org>
	<CAFEAcA_NV69qFLi07QxJR=pjPG0+vjOmXY_J1NpnzUz-qc6ZiQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f9dc1589-b939-3d34-2275-9cf279dfe57d@vivier.eu>
Date: Mon, 12 Nov 2018 15:46:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NV69qFLi07QxJR=pjPG0+vjOmXY_J1NpnzUz-qc6ZiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Don't call gdb_handlesig
 unnecessarily
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Marek Vasut <marex@denx.de>, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 12/11/2018 15:39, Peter Maydell wrote:
> Ping? This got reviewed but hasn't made it to master...

Do you want it in 3.1 too?

Thanks,
Laurent
