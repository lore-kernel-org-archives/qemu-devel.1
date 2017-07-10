Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbbo-00029t-Hd
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUbbn-0002D9-Q5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:32:28 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUbbn-0002Cv-I2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:32:27 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so145679269wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 09:32:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710150440.11303-1-eblake@redhat.com>
References: <20170710150440.11303-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 17:32:05 +0100
Message-ID: <CAFEAcA9KQa_GmXOpgbFyjPPg-8_pdX4+djXkotWM42GyPvVpRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/11] NBD patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 July 2017 at 16:04, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 94c56652b9079cfb9d560a6dde7ecb15eb9ef9c7:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-07-10 14:06:49 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-10-v2
>
> for you to fetch changes up to 9588463e747706ffbaf6f4600b5efea2779bc26f:
>
>   nbd: use generic trace subsystem instead of TRACE macro (2017-07-10 09:57:24 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-07-10
>
> - Eric Blake: MAINTAINERS: Promote NBD to supported, with new maintainer
> - Vladimir Sementsov-Ogievskiy: [00/10] nbd refactoring part 2
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
