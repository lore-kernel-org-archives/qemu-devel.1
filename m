Received: from eggs.gnu.org ([209.51.188.92]:42806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtXHY-0005FE-7T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtX9Q-0006SH-Cm
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:27:02 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtX9P-0006OL-PU
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:26:59 -0500
Received: by mail-ot1-x331.google.com with SMTP id z19so4093837otm.2
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 04:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20190212040136.30371-1-stefanha@redhat.com>
In-Reply-To: <20190212040136.30371-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 12:26:47 +0000
Message-ID: <CAFEAcA-v63BhuFqdh+iEh4MCw4DVLBaEWwCZwwbFazxEU-nntw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 12 Feb 2019 at 04:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 9a6719d572e99a4e79f589d0b73f7475b86f982d:
>
>   virtio-blk: cleanup using VirtIOBlock *s and VirtIODevice *vdev (2019-02-12 11:49:17 +0800)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
