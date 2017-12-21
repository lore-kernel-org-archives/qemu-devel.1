Received: from eggs.gnu.org ([2001:4830:134:3::10]:41530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0fP-0001XK-F6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0fO-00011L-K1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:13:43 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:39138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS0fO-00010e-F0
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:13:42 -0500
Received: by mail-oi0-x230.google.com with SMTP id r63so16805140oia.6
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 05:13:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
References: <20171221013600.17648-1-eblake@redhat.com>
	<20171221013600.17648-5-eblake@redhat.com>
	<47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 13:13:21 +0000
Message-ID: <CAFEAcA-Pd5wzSDttMumMizUTCh7oxzO-dodAMb1H9b5_x5R_7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] STOP Re: [PULL 4/4] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 21 December 2017 at 09:07, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> no, I've updated it, we discussed with Kevin that this approach is bad

To say that a pullreq is bad you need to reply to the cover letter,
there's no guarantee I'll notice a followup to one of the
individual patches in it. (As it happens I saw this email so
I'll take the pullreq out of the queue.)

thanks
-- PMM
