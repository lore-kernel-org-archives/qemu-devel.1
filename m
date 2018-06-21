Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVvVm-0006YZ-IC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVvVl-0005pN-JW
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:04:14 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:33100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVvVl-0005oy-CX
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:04:13 -0400
Received: by mail-oi0-x22f.google.com with SMTP id c6-v6so2259388oiy.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 02:04:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Jun 2018 10:03:52 +0100
Message-ID: <CAFEAcA8TjkgNrEGJ9Z_vmwD_Upf8sjRFms5jKZiV4fBHCsRJ2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] bitmap export over NBD
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

On 21 June 2018 at 04:19, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-06-20
>
> for you to fetch changes up to 5bde4bbbd1e217c323551d2785a0efff6340d840:
>
>   docs/interop: add nbd.txt (2018-06-20 21:20:05 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2018-06-20
>
> Add experimental x-nbd-server-add-bitmap to expose a disabled
> bitmap over NBD, in preparation for a pull model incremental
> backup scheme.
>
> - Eric Blake: tests: Simplify .gitignore
> - Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
>

The patchew errors for this pullreq look like they're real --
do you want to fix them up and resend?

thanks
-- PMM
