Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAOm-0003cv-Da
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAOl-00087O-GD
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:08:08 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:43431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAOl-00087F-BR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:08:07 -0400
Received: by mail-ot0-x233.google.com with SMTP id y10-v6so13561471otg.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:08:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526042199-45745-1-git-send-email-pbonzini@redhat.com>
References: <1526042199-45745-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:07:46 +0100
Message-ID: <CAFEAcA-PhsngpWF3x0Q5OwR1GQ=8UsCiG25OmZPODF1Bc_pstA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/29] Misc patches for 2018-05-09
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

On 11 May 2018 at 13:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit cc8f8ba754bba17eea9791d67b572eb26e30b4ce:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-05-08 15:25:17 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5b27a92dcc5afb11d38c7fe0a637d5d64d31108a:
>
>   rename included C files to foo.inc.c, remove osdep.h (2018-05-11 14:33:40 +0200)
>
> ----------------------------------------------------------------
> * Don't silently truncate extremely long words in the command line
> * dtc configure fixes
> * MemoryRegionCache second try
> * Deprecated option removal
> * add support for Hyper-V reenlightenment MSRs
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
