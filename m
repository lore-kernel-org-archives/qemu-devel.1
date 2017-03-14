Received: from eggs.gnu.org ([2001:4830:134:3::10]:51613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnrwa-0002bl-0z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnrwZ-0002PE-61
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:16 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnrwZ-0002Ok-0q
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:15 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t189so6943838wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:17:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 19:16:53 +0000
Message-ID: <CAFEAcA8gsn62vF35dk-28gimDH+kCSMfmTn6c9TzuT4XkYLR0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/18] Misc patches for QEMU 2.9 hard freeze
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

On 14 March 2017 at 16:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 94b5d57d2f5a3c849cecd65e424bb6f50b998df9:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170314' into staging (2017-03-14 10:13:19 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2563c9c6b8670400c48e562034b321a7cf3d9a85:
>
>   nbd/client: fix drop_sync [CVE-2017-2630] (2017-03-14 14:41:19 +0100)
>
> ----------------------------------------------------------------
> * "x" monitor command fix for KVM (Christian)
> * MemoryRegion name documentation (David)
> * mem-prealloc optimization (Jitendra)
> * -icount/MTTCG fixes (me)
> * "info mtree" niceness (Peter)
> * NBD drop_sync buffer overflow (Vladimir/Eric)
> * small cleanups and bugfixes (Li, Lin, Suramya, Thomas)
> * fix for "-device kvmclock" w/TCG (Eduardo)
> * debug output before crashing on KVM_{GET,SET}_MSRS (Eduardo)
>

Applied, thanks.

-- PMM
