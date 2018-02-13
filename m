Received: from eggs.gnu.org ([2001:4830:134:3::10]:47502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elghq-0001RW-RX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elghq-0003hx-0S
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:57:34 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:36874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elghp-0003hX-R5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:57:33 -0500
Received: by mail-ot0-x22f.google.com with SMTP id e64so18350445ote.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:57:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518537073-30551-1-git-send-email-pbonzini@redhat.com>
References: <1518537073-30551-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 19:57:12 +0000
Message-ID: <CAFEAcA94XUGG5pO7CLdA3S8z2K09CZ7+peLuy5T46Aa2C2rsZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/48] Miscellaneous patches for
 2017-02-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 15:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 7d848450b6e2a3e14a776b4c93704710e7f3d233:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180212' into staging (2018-02-12 14:52:48 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7524a39d8c7c9ff54504cfeb784909e4f49d6f30:
>
>   travis: use libgcc-4.8-dev (libgcc-6-dev is not available on Ubuntu 14.04) (2018-02-13 16:15:09 +0100)
>
> ----------------------------------------------------------------
> * CAN bus (will be under network maintainner)
> * scsi-block opblockers (myself)
> * Dirty log bitmap cleanup (myself)
> * SDHCI improvements and tests (Philippe)
> * HAX support for larger guest sizese (Yu Ning)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
