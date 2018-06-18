Received: from eggs.gnu.org ([2001:4830:134:3::10]:59727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUsBp-0008LS-AN
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUsBj-0007xs-Jd
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:19:17 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUsBj-0007xX-El
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:19:11 -0400
Received: by mail-ot0-x241.google.com with SMTP id l15-v6so18011288oth.6
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:19:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608200150.7032-1-programmingkidx@gmail.com>
References: <20180608200150.7032-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Jun 2018 12:18:50 +0100
Message-ID: <CAFEAcA9F1sTX_9b5PJL61K5eRsP9XoY3KKje_4CNh71JKiw39w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: fix absolute mode
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

On 8 June 2018 at 21:01, John Arbuckle <programmingkidx@gmail.com> wrote:
> Fix the cocoa front-end to correctly be able to use absolute mode.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

This commit message is insufficiently detailed, which makes
it hard to review the patch. When you send patches, please
can you provide commit messages which describe what the
problem is, where the current code gets things wrong and
why the changes fix the issue? It is painful to have to
reverse-engineer your design from your code changes.

thanks
-- PMM
