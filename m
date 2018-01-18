Received: from eggs.gnu.org ([2001:4830:134:3::10]:52157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec8ch-0006hB-PJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec8ch-0002kt-45
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:47 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:39548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec8cg-0002kk-V6
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:47 -0500
Received: by mail-oi0-x231.google.com with SMTP id t8so15474431oie.6
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:44:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108180707.7976-1-programmingkidx@gmail.com>
References: <20180108180707.7976-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 11:44:25 +0000
Message-ID: <CAFEAcA_mvF8FRNfief19zt6_WrxjoKFfbT5dn6d-PchMqdu8Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] cocoa.m: Fix scroll wheel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 January 2018 at 18:07, John Arbuckle <programmingkidx@gmail.com> wrote:
> When using a mouse's scroll wheel in a guest with
> the cocoa front-end, the mouse pointer moves up
> and down instead of scrolling the window. This
> patch fixes this problem.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

Applied to master, thanks.

-- PMM
