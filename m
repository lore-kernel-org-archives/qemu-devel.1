Received: from eggs.gnu.org ([209.51.188.92]:46613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizD0-0004TH-0Z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizCz-0003wW-5N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:11:06 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:35255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gizCy-0003vu-Ee
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:11:05 -0500
Received: by mail-ot1-x329.google.com with SMTP id 81so18835872otj.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20190111135835.3453-1-kraxel@redhat.com>
In-Reply-To: <20190111135835.3453-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 10:10:51 +0000
Message-ID: <CAFEAcA8=+s-FjPL6+VWqbmZi56O=9hAJkPDC3mzrK8xJZScXVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Vga 20190111 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Fri, 11 Jan 2019 at 14:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit a311f891abf3833c1e4c5a62a6e5b0f1b81f22c3:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-01-10 17:49:54 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190111-pull-request
>
> for you to fetch changes up to b05b267840515730dbf6753495d5b7bd8b04ad1c:
>
>   i2c-ddc: fix oob read (2019-01-11 11:45:00 +0100)
>
> ----------------------------------------------------------------
> vga: enable virtio test, fix ddc oob read
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   i2c-ddc: fix oob read
>
> Thomas Huth (1):
>   tests/display-vga: Enable virtio-vga test
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
