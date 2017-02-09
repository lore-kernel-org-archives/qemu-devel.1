Received: from eggs.gnu.org ([2001:4830:134:3::10]:51224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbt8V-0005qp-T3
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbt8U-0008Px-MJ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:08:03 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbt8U-0008PQ-EU
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:08:02 -0500
Received: by mail-wm0-x22f.google.com with SMTP id 196so59670821wmm.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 10:08:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
References: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 18:07:40 +0000
Message-ID: <CAFEAcA8fheZWfNHQqsa4e3QNpeBj0bAM4gh2U9=mi3jGueduwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/10] vnc: add support for multiple
 listening sockets.
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

On 9 February 2017 at 16:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the UI patch queue, carrying only vnc updates this time.  Big
> chunk is the multiple sockets support patch series, but there are also
> some smaller fixes and cleanups.
>
> v2: squash in the clang fix from Daniel.
>
> please pull,
>   Gerd
>
> The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170209-2
>
> for you to fetch changes up to 396f935a9aff3cefd288bdb2b20024fb9dcfa062:
>
>   ui: add ability to specify multiple VNC listen addresses (2017-02-09 17:28:49 +0100)
>
> ----------------------------------------------------------------
> vnc: add support for multiple listening sockets.
> vnc: misc fixes and cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
