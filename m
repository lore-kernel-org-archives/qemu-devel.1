Received: from eggs.gnu.org ([2001:4830:134:3::10]:39977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOQLS-00067j-Nb
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOQLR-00058m-QJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:18:02 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOQLR-00058B-KB
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:18:01 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so70064338wrb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:18:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170623124829.24260-1-kraxel@redhat.com>
References: <20170623124829.24260-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 16:17:39 +0100
Message-ID: <CAFEAcA8nnK4h=Gb-Vp3awDRw-D53ohKVBWH37H56XNhEcDXWAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Queue/misc patches
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

On 23 June 2017 at 13:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e393832:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-22 19:01:58 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/queue/misc-pull-request
>
> for you to fetch changes up to 1b8274d4f926836a4c773c310318e6039c4794a1:
>
>   applesmc: fix port i/o access width (2017-06-23 13:35:01 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Gabriel L. Somlo (3):
>   applesmc: cosmetic whitespace and indentation cleanup
>   applesmc: implement error status port
>   applesmc: fix port i/o access width
>
>  hw/misc/applesmc.c | 219 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 155 insertions(+), 64 deletions(-)

Applied, thanks.

-- PMM
