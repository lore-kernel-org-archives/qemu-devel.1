Received: from eggs.gnu.org ([2001:4830:134:3::10]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQqi0-0005Aa-A7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQqhz-0006nn-Jz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:55:52 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:36421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQqhz-0006nY-F9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:55:51 -0400
Received: by mail-ot0-x229.google.com with SMTP id c15-v6so781942otl.3
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 01:55:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605200425.24323.56023.stgit@gimli.home>
References: <20180605200425.24323.56023.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 09:55:30 +0100
Message-ID: <CAFEAcA-T9FcK3HWoCrchUKk_hmtAsPiKWsso=4ptn9VBu42ysQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] VFIO updates 2018-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 June 2018 at 21:06, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 41feb5b955f0d7c9d071b2c5adbc404ae2895c7a:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-06-05 10:38:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180605.0
>
> for you to fetch changes up to 8151a9c56d31eeeea872b8103c8b86d03c411667:
>
>   vfio/pci: Default display option to "off" (2018-06-05 08:28:09 -0600)
>
> ----------------------------------------------------------------
> VFIO updates 2018-06-05
>
>  - Removed unused DPRINTF (Tiwei Bie)
>  - KVM & VFIO ioeventfd support for NVIDIA MSI ACK (Alex Williamson)
>  - Default vfio-pci display support to "off" (Alex Williamson)
>

Applied, thanks.

-- PMM
