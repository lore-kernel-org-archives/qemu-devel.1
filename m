Received: from eggs.gnu.org ([2001:4830:134:3::10]:51223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHMX-0000uS-7y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHMW-00046o-E4
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:00:49 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chHMW-00046W-7k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:00:48 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so16446740wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 07:00:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487943877-17318-1-git-send-email-kraxel@redhat.com>
References: <1487943877-17318-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 15:00:26 +0000
Message-ID: <CAFEAcA8LTg6hb_R6NVvPFMUmnY5VNqE+SRF1Tg0ChxbK09D2VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/1] cirrus: add blit_is_unsafe call to
 cirrus_bitblt_cputovideo (CVE-2017-2620)
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

On 24 February 2017 at 13:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> v2, this time with qemu-stable Cc'ed.
>
> please pull,
>   Gerd
>
> The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-cve-2017-2620-20170224-1
>
> for you to fetch changes up to 92f2b88cea48c6aeba8de568a45f2ed958f3c298:
>
>   cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620) (2017-02-24 14:35:50 +0100)
>
> ----------------------------------------------------------------
> cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)
>
>  hw/display/cirrus_vga.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Applied, thanks.

-- PMM
