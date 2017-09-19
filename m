Received: from eggs.gnu.org ([2001:4830:134:3::10]:45908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duL7D-0004tk-RL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duL7C-0004iB-Qw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:11:15 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duL7C-0004gi-Ib
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:11:14 -0400
Received: by mail-wm0-x233.google.com with SMTP id g206so299985wme.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:11:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919142758.13577-1-pbonzini@redhat.com>
References: <20170919142758.13577-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 17:10:52 +0100
Message-ID: <CAFEAcA_G_XJ-FcD8VVVHj=QQAmmyM9OsaQORxLuZN0U80pwu9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/51] Misc patches for 2017-09-19
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

On 19 September 2017 at 15:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ecc8:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2017-09-19 10:13:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7437866bfc3b25663f415a8c660fd78360e84598:
>
>   docker: fix creation of archives (2017-09-19 16:20:49 +0200)
>
> ----------------------------------------------------------------
> * warning improvements (Alistair)
> * KVM code cleanup (David)
> * scsi-block support for rerror/werror (Fam)
> * support for >64 vCPUs in Windows (Gonglei)
> * SCSI fix (Hannes)
> * SSE bugfixes (Joseph)
> * SmartOS compilation fixes (Kamil)
> * Hyper-V frequency MSR support (Ladi)
> * move more files to accel/tcg (Philippe, Thomas)
> * multiboot validation (PJP)
> * virtqueue size configuration for virtio-scsi (Richard)
> * Hyper-V header cleanup (Roman)
> * Maintainer email update (Guangrong)
> * checkpatch.pl --branch (Daniel), fixes (Greg)
> * introducing scsi/ (me)

Applied, thanks.

-- PMM
