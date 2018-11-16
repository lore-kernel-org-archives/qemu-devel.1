Received: from eggs.gnu.org ([2001:4830:134:3::10]:37701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNc2b-0000rZ-2c
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNc2W-0007iT-Ez
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:12:01 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:46986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNc2W-0007f1-2l
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:11:56 -0500
Received: by mail-oi1-x235.google.com with SMTP id x202so7941043oif.13
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 03:11:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542339811-18549-1-git-send-email-jasowang@redhat.com>
References: <1542339811-18549-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 11:11:28 +0000
Message-ID: <CAFEAcA-ywk5aVkpgOXmforvmEF94VPPj6SOFRibQmE0=jBcoMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2018 at 03:43, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit d835c6192495dc5b2c3a15a0761eb57d8d310828:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-11-15-1' into staging (2018-11-15 14:18:25 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 013a62020a92f371555c67342424f2f944b62be4:
>
>   net/filter-rewriter.c: Fix coverity static analysis issue (2018-11-16 11:08:26 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Zhang Chen (1):
>       net/filter-rewriter.c: Fix coverity static analysis issue
>
>  net/filter-rewriter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Applied, thanks.

-- PMM
