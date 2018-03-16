Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewowk-0003tU-OZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewowj-0006VB-Mm
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:58:58 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:34733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewowj-0006Ux-Fe
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:58:57 -0400
Received: by mail-oi0-x230.google.com with SMTP id e79so4564773oih.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 12:58:35 +0000
Message-ID: <CAFEAcA9L_ypbNFf+Dv_Sy=vVVv9xvUrG2hrS4xEtnTea2U599w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/69] Misc patches for QEMU soft freeze
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

On 13 March 2018 at 22:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Not sure why this didn't make it to the list yesterday---most likely I
> didn't remove --dry-run...  Now I understand why everybody was waiting
> for my pull request.
>
> The following changes since commit 819fd4699c7b36d574292bcbd8bc25e9d716c8=
4b:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0309a' into staging (2018-03-12 13:21:53 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0790f86861079b1932679d0f011e431aaf4ee9e2:
>
>   tcg: fix cpu_io_recompile (2018-03-12 17:10:38 +0100)
>
> ----------------------------------------------------------------
> * Record-replay lockstep execution, log dumper and fixes (Alex, Pavel)
> * SCSI fix to pass maximum transfer size (Daniel Barboza)
> * chardev fixes and improved iothread support (Daniel Berrang=C3=A9, Pete=
r)
> * checkpatch tweak (Eric)
> * make help tweak (Marc-Andr=C3=A9)
> * make more PCI NICs available with -net or -nic (myself)
> * change default q35 NIC to e1000e (myself)
> * SCSI support for NDOB bit (myself)
> * membarrier system call support (myself)
> * SuperIO refactoring (Philippe)
> * miscellaneous cleanups and fixes (Thomas)
>

Applied, thanks.

-- PMM
