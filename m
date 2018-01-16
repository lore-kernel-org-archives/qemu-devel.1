Received: from eggs.gnu.org ([2001:4830:134:3::10]:41182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebVAC-0000bq-Kt
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebVAB-00016i-Oi
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:36:44 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebVAB-00016U-JC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:36:43 -0500
Received: by mail-ot0-x233.google.com with SMTP id 53so14329144otj.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 09:36:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 17:36:22 +0000
Message-ID: <CAFEAcA-bojSVZd3BHGBrn+HC90fxxfxqnnOg0_tr1yJ-4J3jsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/51] Misc patches for 2018-01-12
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

On 16 January 2018 at 14:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9=
ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b5976c2e46e86b36b01d8ac380a182e22209a7cd:
>
>   scripts/analyse-locks-simpletrace.py: script to analyse lock times (201=
8-01-16 14:54:52 +0100)
>
> ----------------------------------------------------------------
> * QemuMutex tracing improvements (Alex)
> * ram_addr_t optimization (David)
> * SCSI fixes (Fam, Stefan, me)
> * do {} while (0) fixes (Eric)
> * KVM fix for PMU (Jan)
> * memory leak fixes from ASAN (Marc-Andr=C3=A9)
> * migration fix for HPET, icount, loadvm (Maria, Pavel)
> * hflags fixes (me, Tao)
> * block/iscsi uninitialized variable (Peter L.)
> * full support for GMainContexts in character devices (Peter Xu)
> * more boot-serial-test (Thomas)
> * Memory leak fix (Zhecheng)
>

Applied, thanks.

-- PMM
