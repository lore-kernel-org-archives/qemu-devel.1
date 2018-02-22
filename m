Received: from eggs.gnu.org ([2001:4830:134:3::10]:43262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot06-0004VQ-1Z
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot05-0001dE-5R
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:38 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eot04-0001cr-W4
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:41:37 -0500
Received: by mail-ot0-x230.google.com with SMTP id k7so4293630otj.0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:41:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:41:15 +0000
Message-ID: <CAFEAcA_it_ecsaDXHo7TVg88KrJJyG5z26i+ccKkfcX=X46zBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Ui 20180222 patches
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

On 22 February 2018 at 10:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180222-pull-request
>
> for you to fetch changes up to abb4f2c9655503f14dc55064f29c4f59b07e96ff:
>
>   keymap: consider modifier state when picking a mapping (2018-02-22 10:35:32 +0100)
>
> ----------------------------------------------------------------
> ui: reverse keymap improvements.
> sdl2: hotkey fix.
> opengl: dmabuf fixes.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
