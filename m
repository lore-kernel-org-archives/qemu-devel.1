Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceRP6-0001PB-Kg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceRP5-0002lw-Ml
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:07:44 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceRP5-0002kv-Fn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:07:43 -0500
Received: by mail-wr0-x232.google.com with SMTP id 89so13696307wrr.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 11:07:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487266718-108184-1-git-send-email-pbonzini@redhat.com>
References: <1487266718-108184-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 19:07:21 +0000
Message-ID: <CAFEAcA-6PbfGfQqkdDqZ_o32KFDMxNUUfBb=xpUza5Z9i9_YSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/23] Misc patches for 2017-02-16
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

On 16 February 2017 at 17:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 65c9d60a3ad3249784348824eca69acac455bc02:
>
>   target-i386: correctly propagate retaddr into SVM helpers (2017-02-16 18:37:01 +0100)
>
> ----------------------------------------------------------------
> * GUEST_PANICKED improvements (Anton)
> * vCont gdbstub rewrite (Claudio)
> * Fix CPU creation with -device (Liyang)
> * Logging fixes for pty chardevs (Ed)
> * Makefile "move if changed" fix (Lin)
> * First part of cpu_exec refactoring (me)
> * SVM emulation fix (me)
> * apic_delivered fix (Pavel)
> * "info ioapic" fix (Peter)
> * qemu-nbd socket activation (Richard)
> * QOMification of mcf_uart (Thomas)
>

Applied, thanks.

-- PMM
