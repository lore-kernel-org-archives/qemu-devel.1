Received: from eggs.gnu.org ([2001:4830:134:3::10]:47077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e091L-0006aA-Np
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e091K-00070M-Qh
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:29:11 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:53235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e091K-0006z8-KP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:29:10 -0400
Received: by mail-wr0-x230.google.com with SMTP id k62so11262249wrc.9
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:29:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005142547.1363-1-stefanha@redhat.com>
References: <20171005142547.1363-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 17:28:48 +0100
Message-ID: <CAFEAcA9hW1wCwY3mG3x9YQJ_7SemP-Ox3jRjgJG7R6ngYD8Jow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2017 at 15:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 5456c6a4ec9cd8fc314ddc303e88bf85c110975c:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-05 12:02:21 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 45042732f39ecd42794c256bf98f231e58849c3e:
>
>   checkpatch: fix incompatibility with old perl (2017-10-05 10:22:44 -0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Vladimir Sementsov-Ogievskiy (1):
>   checkpatch: fix incompatibility with old perl
>
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
