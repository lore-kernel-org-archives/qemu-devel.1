Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEDQF-0004B7-6u
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEDLP-0004kc-72
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:00:35 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:35013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEDLP-0004h2-19
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:00:35 -0400
Received: by mail-oi1-x22b.google.com with SMTP id 22-v6so30154747oiz.2
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:00:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539949778-13129-1-git-send-email-pbonzini@redhat.com>
References: <1539949778-13129-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Oct 2018 14:00:04 +0100
Message-ID: <CAFEAcA8cqwd4zc4Wyw0PDkXgP4HA+roiPXadDrksg8VQEY9AuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/47] Miscellaneous patches for
 2018-10-18
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

On 19 October 2018 at 12:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 74c0b816adfc6aa1b01b4426fdf385e32e35cbac:
>
>   replay: pass raw icount value to replay_save_clock (2018-10-19 13:44:15 +0200)
>
> ----------------------------------------------------------------
> * RTC fixes (Artem)
> * icount fixes (Artem)
> * rr fixes (Pavel, myself)
> * hotplug cleanup (Igor)
> * SCSI fixes (myself)
> * 4.20-rc1 KVM header update (myself)
> * coalesced PIO support (Peng Hao)
> * HVF fixes (Roman B.)
> * Hyper-V refactoring (Roman K.)
> * Support for Hyper-V IPI (Vitaly)

Applied, thanks.

-- PMM
