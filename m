Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIdIb-0005HE-Ol
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIdIb-0000x8-0b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:59:41 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIdIa-0000wk-Qp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:59:40 -0400
Received: by mail-ot0-x243.google.com with SMTP id 15-v6so1000269otn.12
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:59:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 17:59:19 +0100
Message-ID: <CAFEAcA_qieZMT3Z=ZQzkG44z+ovkWde8XF=3T0yGi6b6nu_iJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/37] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2018 at 16:39, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2ae:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-request' into staging (2018-05-15 12:50:06 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1fce860ea5eba1ca00a67911fc0b8a5d80009514:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2018-05-15' into queue-block (2018-05-15 16:19:53 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Switch AIO/callback based block drivers to a byte-based interface
> - Block jobs: Expose error string via query-block-jobs
> - Block job cleanups and fixes
> - hmp: Allow using a qdev id in block_set_io_throttle
> - Copy-on-read block driver
> - The qcow2 default refcount cache size has been decreased
> - Various bug fixes

Applied, thanks.

-- PMM
