Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cm3CN-0007Ca-34
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cm3CL-0006f1-P6
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:54:03 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cm3CL-0006ep-GF
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:54:01 -0500
Received: by mail-wr0-x231.google.com with SMTP id u48so51254309wrc.0
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 10:53:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
References: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Mar 2017 19:53:37 +0100
Message-ID: <CAFEAcA_0zyCiwhu6jAmUUS-f_0fePcbPRPhKQf=a6g=m868KDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/2] bugfixes for ohci and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2017 at 10:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> 2.9 fixes queue, with two patches for qxl and ohci.
>
> please pull,
>   Gerd
>
> The following changes since commit 87467097f8811258cd91d42c141a7bd8492ed08a:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-02-28-v4' into staging (2017-03-07 17:06:48 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-fixes-20170309-1
>
> for you to fetch changes up to dbb5fb8d3519130559b10fa4e1395e4486c633f8:
>
>   qxl: clear guest_cursor on QXL_CURSOR_HIDE (2017-03-09 09:47:26 +0100)
>
> ----------------------------------------------------------------
> 2.9 bugfixes for ohci and qxl
>
> ----------------------------------------------------------------
> Gerd Hoffmann (2):
>       ohci: relax link check
>       qxl: clear guest_cursor on QXL_CURSOR_HIDE
>
>  hw/display/qxl.c  | 5 +++++
>  hw/usb/hcd-ohci.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>


Applied, thanks.

-- PMM
