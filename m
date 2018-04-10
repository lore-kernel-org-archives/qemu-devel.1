Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5u75-00048Z-1t
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5u74-0004CO-2X
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:19:11 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5u73-0004Bw-Sk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:19:09 -0400
Received: by mail-ot0-x230.google.com with SMTP id o9-v6so12914546otj.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 07:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410092446.26903-1-kraxel@redhat.com>
References: <20180410092446.26903-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 15:18:48 +0100
Message-ID: <CAFEAcA_Zfobt29YmQjGGnfsg9oWF1wtgLZccqC=F-j1F6=cQ1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Ui 20180410 patches
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

On 10 April 2018 at 10:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b32:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-04-09 17:29:10 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180410-pull-request
>
> for you to fetch changes up to c6093a05d6a84d2144bb6462cf20e907eddf8aeb:
>
>   configure: don't warn SDL abi if disabled (2018-04-10 11:22:03 +0200)
>
> ----------------------------------------------------------------
> configure: don't warn on old sdl/gtk versions if disabled.
> keymap + gtk fixes.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
