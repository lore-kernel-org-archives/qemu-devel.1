Received: from eggs.gnu.org ([2001:4830:134:3::10]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7e0b-0006Cb-QK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7e0a-0005Y0-Sa
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:03:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7e0a-0005XT-Bp
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:03:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id o13-v6so4955125otl.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
References: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Oct 2018 11:03:34 +0100
Message-ID: <CAFEAcA_7RQvuxkqx-QwpfjVGX3XFOX51qQb7yauHt3Tw_QWnVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/80] Misc patches for 2018-09-30
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

On 2 October 2018 at 18:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 3892f1f1a963e59dfe012cd9d461d33b2986fa=
3b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/libfdt-20181002' int=
o staging (2018-10-02 09:54:44 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 97866508669c4a75f531bfa94f8267900fcbb5dc:
>
>   hw/scsi/mptendian: Avoid taking address of fields in packed structs (20=
18-10-02 19:09:14 +0200)
>
> ----------------------------------------------------------------
> * configure fix for environment variables (Daniel)
> * fix memory leaks (Alex)
> * x86_64 MTTCG fixes (Emilio)
> * introduce atomic64 (Emilio)
> * Fix for virtio hang (Fam, myself)
> * SH serial port fix (Geert)
> * Deprecate rotation_rate for scsi-block (Fam)
> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
> * MSI/IOMMU fix (Jan)
> * Socket reconnection fixes (Marc-Andr=C3=A9)
> * icount fixes (Emilio, myself)
> * QSP fixes for Coverity (myself)
> * Some record/replay improovements (Pavel)
> * Packed struct fixes (Peter)
> * Windows dump fixes and elf2dmp (Viktor)
> * kbmclock fix (Yongji)

Applied, thanks.

-- PMM
