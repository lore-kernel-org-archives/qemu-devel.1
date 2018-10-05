Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RIY-0000nx-FU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RIX-0002xi-QR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:41:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8RIX-0002wW-Jd
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:41:45 -0400
Received: by mail-ot1-x342.google.com with SMTP id j9-v6so12934590otl.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005143802.18412-1-peter.maydell@linaro.org>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 15:41:24 +0100
Message-ID: <CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2018 at 15:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> The test-bdrv-drain test fails at least 50% of the time
> on my OS build system. Disable the test until we can figure

This is a typo: I meant "OSX build system".

> out what's going on, as this makes pull request processing
> very difficult.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
