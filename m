Received: from eggs.gnu.org ([2001:4830:134:3::10]:57653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e70mf-0000J5-Sx
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e70mf-00070V-3P
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:06:25 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:53030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e70me-0006zw-T5
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:06:25 -0400
Received: by mail-wr0-x241.google.com with SMTP id k62so21011319wrc.9
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 08:06:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023080245.31300-1-kraxel@redhat.com>
References: <20171023080245.31300-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 16:06:03 +0100
Message-ID: <CAFEAcA95C0MgB13SnwQ0xLi_b0nd1bqKWQvHW_D_MxZKEwOVkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Fixes 20171023 patches
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

On 23 October 2017 at 09:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20171023-pull-request
>
> for you to fetch changes up to 8172bdb2d0c829462f8c4fb2cb54a768d295a747:
>
>   scripts: don't throw away stderr when checking out git submodules (2017-10-23 08:10:18 +0200)
>
> ----------------------------------------------------------------
> fixes for the fallout of the recent ui and keymap merges.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   scripts: don't throw away stderr when checking out git submodules
>
> Gerd Hoffmann (1):
>   ui: add qemu-keymap and shader to .gitignore
>
> Laurent Vivier (1):
>   configure: disable qemu-keymap for linux-user qemu
>
>  configure                | 6 +++---
>  .gitignore               | 2 ++
>  scripts/git-submodule.sh | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
