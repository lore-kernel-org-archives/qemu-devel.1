Received: from eggs.gnu.org ([2001:4830:134:3::10]:37550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erPRG-0006HH-U9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erPRG-00082E-7X
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:44:06 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erPRG-00080v-1I
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:44:06 -0500
Received: by mail-oi0-x241.google.com with SMTP id u73so4638194oie.3
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:44:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180301075428.17320-1-famz@redhat.com>
References: <20180301075428.17320-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:43:44 +0000
Message-ID: <CAFEAcA-T8ARdTA=fGJKD9iiJoCtCDAqSU=Q3_7bMadJ1AQSoHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches 2018-03-01
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

On 1 March 2018 at 07:54, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 6697439794f72b3501ee16bb95d16854f9981421:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180227-pull-request' into staging (2018-02-27 17:50:46 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to 78d8c99e297eba32897d8a5bdaa005670549d6f7:
>
>   block/nvme: fix Coverity reports (2018-03-01 15:21:46 +0800)
>
> ----------------------------------------------------------------
>
> Coverity error fix for nvme://
>
> ----------------------------------------------------------------
>
> Paolo Bonzini (1):
>   block/nvme: fix Coverity reports
>
>  block/nvme.c        | 10 +++++++---
>  util/vfio-helpers.c |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> --

Applied, thanks.

-- PMM
