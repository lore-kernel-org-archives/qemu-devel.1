Received: from eggs.gnu.org ([2001:4830:134:3::10]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBgCB-0002yK-HC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBgC5-00006g-NZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:08:03 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:48999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBgC5-00006C-Gi
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:07:57 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 15so8350149wrb.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 04:07:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171105145625.7817-1-pbonzini@redhat.com>
References: <20171105145625.7817-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 12:07:35 +0000
Message-ID: <CAFEAcA-+rNV=yb9Vyq6-W-k0y4C5QD5-y00x0vZMvMjuCH3qNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Changes for 2017-11-05
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

On 5 November 2017 at 14:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit b33afc415622e5eb26e0f14fd27eb86e32a5472e:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-ci-updates-for-softfreeze-021117-2' into staging (2017-11-03 10:08:34 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 20bc94a2b8449b7700b6bfa25a87ce2320a1c649:
>
>   build: disable -Wmissing-braces on older compilers (2017-11-05 14:52:10 +0100)
>
> (I see some brokenness in check-qtest-sparc, but not caused by
> my two patches of course).
>
> ----------------------------------------------------------------
> * Remove legacy KVM PCI device assignment
> * Fix qemu-pr-helper.c compilation on older compilers
>

Applied, thanks.

-- PMM
