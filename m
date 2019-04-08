Received: from eggs.gnu.org ([209.51.188.92]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDXTf-00015b-Fs
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDXTe-0005fz-HM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDXTe-0005f4-8i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:34 -0400
Received: by mail-ot1-x32b.google.com with SMTP id o74so12812431ota.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 09:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190408110920.30119-1-thuth@redhat.com>
In-Reply-To: <20190408110920.30119-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 17:50:21 +0100
Message-ID: <CAFEAcA8QgQJJi+rH4gFfrx7BKo98fMjtyJgLU1cCkCs15=h4_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Fixes for libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jafar Abdi <cafer.abdi@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 8 Apr 2019 at 12:09, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git pull-request-2019-04-08
>
> for you to fetch changes up to c19f2b711e15dac4c2cdbace2f8fb3a45fbed0d2:
>
>   test qgraph.c: Fix segs due to out of scope default (2019-04-08 12:38:07 +0200)
>
> ----------------------------------------------------------------
> - Fix a crash in libqos with GCC 9
> - Fix usage of wrong boolean types in libqos
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
