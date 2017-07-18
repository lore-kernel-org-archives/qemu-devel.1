Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXYsW-0008Tq-BV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXYsV-0001QY-HY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:13:56 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXYsV-0001P2-Am
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:13:55 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w4so43811394wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718041705.17614-1-jcody@redhat.com>
References: <20170718041705.17614-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 21:13:33 +0100
Message-ID: <CAFEAcA_uFtZ17RJV49A1W4LPLseO36VqftRFSG+4XYL-mGhzMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 18 July 2017 at 05:17, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 8508eee740c78d1465e25dad7c3e06137485dfbc:
>
>   live-block-ops.txt: Rename, rewrite, and improve it (2017-07-18 00:11:01 -0400)
>
> ----------------------------------------------------------------
> Block patches (documentation)
> ----------------------------------------------------------------
>
> Kashyap Chamarthy (2):
>   bitmaps.md: Convert to rST; move it into 'interop' dir
>   live-block-ops.txt: Rename, rewrite, and improve it

Applied, thanks.

-- PMM
