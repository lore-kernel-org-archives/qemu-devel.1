Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYu0j-0008Bb-9t
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYu0i-0000Ch-F3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:04:29 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:42932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYu0i-0000B6-AG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:04:28 -0400
Received: by mail-ot0-x22b.google.com with SMTP id n24-v6so10031363otl.9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:04:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530270317-28612-1-git-send-email-pbonzini@redhat.com>
References: <1530270317-28612-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:04:06 +0100
Message-ID: <CAFEAcA_QtCeT0VGnj-7Ct09SFvbD+hxGJ4+=hPdTtnJ_FzRvNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/60] Misc patches for soft freeze
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

On 29 June 2018 at 12:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 4a83bf2f339d4b63ecd5ef48b9816c3b7ee245=
53:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180=
627' into staging (2018-06-28 15:31:42 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 28a3cfc10b2e1a34985797357b4aa7558a63d08f:
>
>   tests/boot-serial: Do not delete the output file in case of errors (201=
8-06-29 13:02:50 +0200)
>
> ----------------------------------------------------------------
> * "info mtree" improvements (Alexey)
> * fake VPD block limits for SCSI passthrough (Daniel Barboza)
> * chardev and main loop fixes (Daniel Berrang=C3=A9, Sergio, Stefan)
> * help fixes (Eduardo)
> * pc-dimm refactoring (David)
> * tests improvements and fixes (Emilio, Thomas)
> * SVM emulation fixes (Jan)
> * MemoryRegionCache fix (Eric)
> * WHPX improvements (Justin)
> * ESP cleanup (Mark)
> * -overcommit option (Michael)
> * qemu-pr-helper fixes (me)
> * "info pic" improvements for x86 (Peter)
> * x86 TCG emulation fixes (Richard)
> * KVM slot handling fix (Shannon)
> * Next round of deprecation (Thomas)
> * Windows dump format support (Viktor)
>

Applied, thanks.

-- PMM
