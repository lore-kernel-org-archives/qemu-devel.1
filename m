Received: from eggs.gnu.org ([2001:4830:134:3::10]:42904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQzDL-0001e1-QF
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQzDK-0004h3-CA
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:56:15 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQzDK-0004g4-2H
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:56:14 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k67so206619430wrc.2
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 09:56:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630141040.15353-1-famz@redhat.com>
References: <20170630141040.15353-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 17:55:52 +0100
Message-ID: <CAFEAcA-Bexxq2S0EWxmKD4wJ3HBnCsjgFxEqYgd+FuEA6opALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 June 2017 at 15:10, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 36f87b4513373b3cd79c87c9197d17face95d4ac:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170630' into staging (2017-06-30 11:58:49 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/block-pull-request
>
> for you to fetch changes up to c61e684e44272f2acb2bef34cf2aa234582a73a9:
>
>   block: Exploit BDRV_BLOCK_EOF for larger zero blocks (2017-06-30 21:48:06 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter,
>
> Here are Eric Blake's enhancement to block layer API. Thanks!
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
