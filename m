Received: from eggs.gnu.org ([2001:4830:134:3::10]:52094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC5Jc-0005Pr-Qh
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC5JZ-0002sq-9A
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:55 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:42309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gC5JX-0002oz-8N
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:01:53 -0400
Received: by mail-oi1-x22b.google.com with SMTP id w81-v6so15477537oiw.9
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:01:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181015090517.26884-1-kraxel@redhat.com>
References: <20181015090517.26884-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 17:01:28 +0100
Message-ID: <CAFEAcA_v3DLfoCUyVHoCfW1YDVdWkcj+051OM2a+Ldx5f14Trw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Vga 20181015 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 15 October 2018 at 10:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit a73549f99612f758dec0fdea6ae1c30b6c709a0b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-request' into staging (2018-10-12 16:45:51 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20181015-pull-request
>
> for you to fetch changes up to 9f42e0b3c2355c4a2475124c3fc40421a88de813:
>
>   Makefile: Install new vgabios binaries (2018-10-15 09:57:33 +0200)
>
> ----------------------------------------------------------------
> vga: config tweaks, edid updates, qxl bugfix, install new vgabios blobs.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
