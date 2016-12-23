Received: from eggs.gnu.org ([2001:4830:134:3::10]:43483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKNpK-0005So-BG
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKNpJ-0002oO-9X
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:15:54 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cKNpJ-0002o6-4I
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:15:53 -0500
Received: by mail-vk0-x22c.google.com with SMTP id 137so176507021vkl.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 03:15:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Dec 2016 11:15:32 +0000
Message-ID: <CAFEAcA_EyA1WycYOoqZP767GiufX=DV59v4Hgb=dhk+NoE3X5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] First round of misc patches for QEMU
 2.9
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

On 22 December 2016 at 15:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit d1e8e8ecc3d2a1a72504912d671f1cbbac1b06=
e5:
>
>   Merge remote-tracking branch 'remotes/huth/tags/target-dirs-20161220' i=
nto staging (2016-12-21 21:11:48 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6c7c3c21f95dd9af8a0691c0dd29b07247984122:
>
>   x86: implement la57 paging mode (2016-12-22 16:01:04 +0100)
>
> ----------------------------------------------------------------
> * core support for MemoryRegionCache from myself
> * rules.mak speedup and cleanups from myself and Marc-Adnr=C3=A9
> * multiboot command line fix from Vlad
> * SCSI fixes from myself
> * small qemu-timer speedup from myself
> * x86 debugging improvements from Doug
> * configurable Q35 devices from  Chao
> * x86 5-level paging support from Kirill
> * x86 SHA_NI support for KVM from Yi Sun
> * improved kvmclock migration logic from Marcelo
> * bugfixes and doc fixes from others

Applied, thanks. (Nice to see that git is smart enough to
be able to merge this on top of the earlier target-* rename.)

-- PMM
