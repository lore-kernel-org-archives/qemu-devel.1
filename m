Received: from eggs.gnu.org ([2001:4830:134:3::10]:50018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvMqK-0004LD-SH
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvMqK-0008HV-1i
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:41:48 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvMqJ-0008Gg-Rt
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:41:47 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w11so209250706wrc.3
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 04:41:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 12:41:25 +0100
Message-ID: <CAFEAcA_at0jSHTQqMAP8Ryy_-4a9hjnui6+1Q_jp1o=1Bfgfbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Misc patches for QEMU 2.9.0-rc3
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

On 3 April 2017 at 20:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 95b31d709ba343ad237c3630047ee7438bac4065:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170331.0' into staging (2017-03-31 18:06:13 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ecbddbb106114f90008024b4e6c3ba1c38d7ca0e:
>
>   main-loop: Acquire main_context lock around os_host_main_loop_wait. (2017-04-03 19:13:12 +0200)
>
> ----------------------------------------------------------------
> * MemoryRegionCache revert
> * glib optimization workaround
> * fix "info lapic" segfault on isapc
> * fix QIOChannel memory leak
>

Applied, thanks.

-- PMM
