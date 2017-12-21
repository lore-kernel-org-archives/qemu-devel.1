Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS5Rp-0004sz-Bb
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS5Ro-0007cC-9I
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:20:01 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:35474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS5Ro-0007bc-4a
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:20:00 -0500
Received: by mail-ot0-x234.google.com with SMTP id q5so861426oth.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 10:20:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221083529.6982-1-pbonzini@redhat.com>
References: <20171221083529.6982-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 18:19:38 +0000
Message-ID: <CAFEAcA_Ht4mcJTkc3k4_jh2pBjriA6XTg4eVAsaJHB8REGb8ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/41] First batch of misc patches for
 QEMU 2.12
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

On 21 December 2017 at 08:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba=
26:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-=
18-v2' into staging (2017-12-20 13:20:48 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 194b7f0d448361dd58d2f7f189147cf075988255:
>
>   chardev: convert the socket server to QIONetListener (2017-12-21 09:30:=
32 +0100)
>
> ----------------------------------------------------------------
> * NBD and chardev conversion to QIONetListener (Daniel)
> * MTTCG fixes (David)
> * Hyper-V fixes (Roman, Evgeny)
> * share-rw option (Fam)
> * Mux chardev event bugfix (Marc-Andr=C3=A9)
> * Add systemd unit files in contrib/ (me)
> * SCSI and block/iscsi.c bugfixes (me, Peter L.)
> * unassigned_mem_ops fixes (Peter M.)
> * VEX decoding fix (Peter M.)
> * "info pic" and "info irq" improvements (Peter Xu)
> * vmport trace events (Philippe)
> * Braille chardev bugfix (Samuel)
> * Compiler warnings fix (Stefan)
> * initial support for TCG smoke test of more boards (Thomas)
> * New CPU features (Yang)
> * Reduce startup memory usage (Yang)
> * QemuThread race fix (linhecheng)
>

Applied, thanks.

-- PMM
