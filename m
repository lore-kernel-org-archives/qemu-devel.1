Received: from eggs.gnu.org ([209.51.188.92]:44939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpBpn-0002t4-Ud
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpBpm-00011d-Sc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:52:47 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpBpm-0000xl-Iv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:52:46 -0500
Received: by mail-oi1-x22d.google.com with SMTP id w13so2588823oiw.9
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 04:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20190130031817.27780-1-stefanha@redhat.com>
In-Reply-To: <20190130031817.27780-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 12:52:28 +0000
Message-ID: <CAFEAcA80pfRr7FKFu+0X0MqM5c08O5p88jm_5tRFLxXoNu7-YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 30 Jan 2019 at 03:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit f6b06fcceef465de0cf2514c9f76fe0192896781:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-request' into staging (2019-01-23 17:57:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 57b7bdf426445d8356171135308dfe6d7d5fb612:
>
>   trace: rerun tracetool after ./configure changes (2019-01-30 10:57:03 +0800)
>
> ----------------------------------------------------------------
> Pull request
>
> User-visible changes:
>  * The new qemu-trace-stap script makes it convenient to collect traces without
>    writing SystemTap scripts.  See "man qemu-trace-stap" for details.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
