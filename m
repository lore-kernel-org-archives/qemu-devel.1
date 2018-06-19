Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVJ0x-0000vw-Tv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVJ0x-0005lZ-3X
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:57:52 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:46426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVJ0w-0005l9-Ta
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:57:51 -0400
Received: by mail-oi0-x232.google.com with SMTP id h79-v6so152875oig.13
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:57:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 16:57:29 +0100
Message-ID: <CAFEAcA-LZyARdFAgxCOQQNGro=ydU62fP8b9LXXLO+=ws=46dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/35] Block layer patches
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

On 18 June 2018 at 17:44, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4c790afe2503eab12874508acab5b388d7babfd2:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2018-06-18' into queue-block (2018-06-18 17:20:42 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Active mirror (blockdev-mirror copy-mode=write-blocking)
> - bdrv_drain_*() fixes and test cases
> - Fix crash with scsi-hd and drive_del
>

Applied, thanks.

-- PMM
