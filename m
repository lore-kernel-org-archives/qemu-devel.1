Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NPE-0007dN-39
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NPD-0007RF-7i
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:28 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:41792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3NPD-0007R0-2i
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:59:27 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 188-v6so16233137oih.8
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:59:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522381996-19462-1-git-send-email-jasowang@redhat.com>
References: <1522381996-19462-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 15:59:06 +0100
Message-ID: <CAFEAcA9ktBBLzKjrBwe5mQ0sNd7S8xWWHUfsY2JtupXjJTY9Ug@mail.gmail.com>
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

On 30 March 2018 at 04:53, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-important-fixes' into staging (2018-03-28 22:13:38 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to abbbb0350d780e24d2f6a0cf8fc3191badb0329a:
>
>   qemu-doc: Rework the network options chapter to make "-net" less prominent (2018-03-30 11:44:11 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Thomas Huth (1):
>       qemu-doc: Rework the network options chapter to make "-net" less prominent
>
>  qemu-options.hx | 189 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 94 insertions(+), 95 deletions(-)
>
Applied, thanks.

-- PMM
