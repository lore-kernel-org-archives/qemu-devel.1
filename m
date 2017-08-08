Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df7a6-0008B2-2g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df7a5-0000NT-6H
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:42:10 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1df7a4-0000NH-UU
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:42:09 -0400
Received: by mail-wr0-x229.google.com with SMTP id 33so15027503wrz.4
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 09:42:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2017 17:41:47 +0100
Message-ID: <CAFEAcA-Hh2e28wcNejVDhbwZx=PYqktpEXPvWqEy5_L3Jq-y4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Misc patches for 2017-08-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 August 2017 at 16:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit c233a35d3d91af666aa95a6a3ba8244d4ce728c6:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170803' into staging (2017-08-04 13:03:58 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f5048cb7517348a20ba202e435e1006a8f5001cf:
>
>   maint: Include bug-reporting info in --help output (2017-08-08 17:28:53 +0200)
>
> ----------------------------------------------------------------
> * --help/--version improvements (Eric)
> * GCC 7 workaround (Greg)
> * Small SCSI fix (Hannes)
> * SSE 4.1 fix (Joseph)
> * RCU deadlock fix (myself)
>

Applied, thanks.

-- PMM
