Received: from eggs.gnu.org ([2001:4830:134:3::10]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evgTL-0007rZ-06
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evgTK-0002gj-1A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:43:54 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evgTJ-0002gR-Rd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:43:53 -0400
Received: by mail-oi0-x242.google.com with SMTP id h23so14765446oib.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 02:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312110532.30967-1-kraxel@redhat.com>
References: <20180312110532.30967-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 09:43:32 +0000
Message-ID: <CAFEAcA_15NvxrfdoDYGwBk=_JS3iPNq==+sE7YqVXVBO1z0fcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Usb 20180312 patches
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

On 12 March 2018 at 11:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180312-pull-request
>
> for you to fetch changes up to c7ac1ab0201d47d12b75e1c98d79869bcdad5732:
>
>   usbredir: reorder fields in USBRedirDevice to reduce padding (2018-03-12 11:43:49 +0100)
>
> ----------------------------------------------------------------
> usbredir: reorder fields in USBRedirDevice to reduce padding
>
> ----------------------------------------------------------------
>
> zhenwei.pi (1):
>   usbredir: reorder fields in USBRedirDevice to reduce padding
>
>  hw/usb/redirect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
