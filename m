Received: from eggs.gnu.org ([209.51.188.92]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk8LZ-00041K-Rg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk8LT-0006oU-Uq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:08:41 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:43164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk8LR-0006e1-UQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:08:34 -0500
Received: by mail-ot1-x32a.google.com with SMTP id a11so11162591otr.10
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20190116010106.27626-1-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 14:08:20 +0000
Message-ID: <CAFEAcA9v5KK+ZQOqyQ_TSKc0OTwdxRrvGX59WpFZ_E_2UfadOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 16 Jan 2019 at 01:01, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319dbc:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-15 17:24:00 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 19c021e1948a81c4ba19b3ff735432b45b6aebee:
>
>   Revert "hbitmap: Add @advance param to hbitmap_iter_next()" (2019-01-15 18:26:50 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
