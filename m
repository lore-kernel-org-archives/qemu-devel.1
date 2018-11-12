Received: from eggs.gnu.org ([2001:4830:134:3::10]:42940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDWG-0000oe-LP
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDWF-0005Sc-Vk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:52 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMDWF-0005SJ-PA
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id r127-v6so7353019oie.3
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:48:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f9dc1589-b939-3d34-2275-9cf279dfe57d@vivier.eu>
References: <20181019174958.26616-1-peter.maydell@linaro.org>
	<CAFEAcA_NV69qFLi07QxJR=pjPG0+vjOmXY_J1NpnzUz-qc6ZiQ@mail.gmail.com>
	<f9dc1589-b939-3d34-2275-9cf279dfe57d@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 14:48:30 +0000
Message-ID: <CAFEAcA8HyA7mPAFcj4+F92uSQJui+cH407PaAmyS30yvs=6ERg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 12 November 2018 at 14:46, Laurent Vivier <laurent@vivier.eu> wrote:
> On 12/11/2018 15:39, Peter Maydell wrote:
>> Ping? This got reviewed but hasn't made it to master...
>
> Do you want it in 3.1 too?

Well, it is a bugfix, and we haven't rolled rc1 yet, so I would
default to yes, unless you'd rather defer it to 4.0.

thanks
-- PMM
