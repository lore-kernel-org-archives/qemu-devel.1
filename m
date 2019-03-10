Received: from eggs.gnu.org ([209.51.188.92]:45733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2wr2-0002FP-0a
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2wr1-000620-B8
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2wr1-00060q-4E
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id b3so1609050otp.4
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 04:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Mar 2019 11:42:42 +0000
Message-ID: <CAFEAcA_NBUw78zJz-VmYMCfN2eTQ=N4Zjw34_Fjvbye1FvPKjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] Misc patches for QEMU 4.0 soft freeze
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

On Sat, 9 Mar 2019 at 07:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 62cfabb52210139843e26c95434356f73a0631=
b9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20190307' into=
 staging (2019-03-08 15:17:01 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d7fa7c30d45c375fb7d9ad6f58462a64c3317037:
>
>   exec: streamline flatview_add_to_dispatch (2019-03-09 08:46:56 +0100)
>
> ----------------------------------------------------------------
> * allow building QEMU without TCG or KVM support (Anthony)
> * update AMD IOMMU copyright (David)
> * compilation fixes for GCC and BSDs (Alexey, David, Paolo, Philippe)
> * coalesced I/O bugfix (Jagannathan)
> * Processor Tracing cpuid fix (Luwei)
> * Kconfig fix (Paolo)
> * Cleanups (Paolo)
> * PVH vs. multiboot fix (Stefano)
> * LSI bugfixes (Sven)
> * elf2dmp Coverity fix (Victor)
> * scsi-disk fix (Zhengui)

    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
ERROR: pull request includes tag with UTF-8 error in person name

(Maybe we should add "patch includes LATIN CAPITAL LETTER A WITH TILDE"
in checkpatch.pl as a warning, since it's much more likely to
be "something got doubly-utf-8-encoded" than intentional.)

thanks
-- PMM
