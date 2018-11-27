Received: from eggs.gnu.org ([2001:4830:134:3::10]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRiTO-0001of-0L
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRiE1-0001BA-FH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:36:46 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRiE1-0001Az-85
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:36:45 -0500
Received: by mail-oi1-x236.google.com with SMTP id m6so8532181oig.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:36:45 -0800 (PST)
MIME-Version: 1.0
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 18:36:33 +0000
Message-ID: <CAFEAcA860pRm-d10V3zhdrAunB9JmnwPcHjJwpMMtr5u5TKjpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/15] Misc patches for QEMU 3.1-rc3
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

On Tue, 27 Nov 2018 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 4822f1ee9efa8df56e29db0a68323b484bdb03=
35:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127-pul=
l-request' into staging (2018-11-27 11:21:38 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to cb16c8466b6c62868aba47cd95fadcf316541f40:
>
>   hostmem: no need to check for host_memory_backend_mr_inited() in alloc(=
) (2018-11-27 15:35:19 +0100)
>
> ----------------------------------------------------------------
> * lsi HBA reselection fix (George)
> * Small cleanups (Li Qiang)
> * bugfixes for vhost-user-bridge and hostmem (Marc-Andr=C3=A9)
> * single-thread TCG fix (me)
> * VMX migration blocker (me)
> * target/i386 fix for LOCK (Richard)
> * fix elf2dmp check (Roman)
> * MAINTAINERS update (Philippe, Thomas)
>
> ----------------------------------------------------------------

I'll delay rc3 til tomorrow so we can get a v3 of this pullreq
in, in the hope of making rc3 our last before release...

thanks
-- PMM
