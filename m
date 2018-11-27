Received: from eggs.gnu.org ([2001:4830:134:3::10]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRa4X-00010P-Ss
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRa4X-0003Be-1Q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:54:25 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRa4W-0003BK-Rx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:54:24 -0500
Received: by mail-oi1-x231.google.com with SMTP id v6so18743157oif.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 01:54:24 -0800 (PST)
MIME-Version: 1.0
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 09:54:13 +0000
Message-ID: <CAFEAcA9azv5Anx6BZ8kieVbo3=QWshb2FK2+Cee2e17eV_KzKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/15] Misc patches for QEMU 3.1-rc3
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

On Mon, 26 Nov 2018 at 19:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d522fba24478474911b0e6e488b6d1dcf1af54=
f8:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81126' into staging (2018-11-26 13:58:46 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b6a1ae97bad8dbad43d5614e4c88c1f50e9ee737:
>
>   hostmem: no need to check for host_memory_backend_mr_inited() in alloc(=
) (2018-11-26 20:35:19 +0100)
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


[staging 0c3280bba9] Merge remote-tracking branch
'remotes/bonzini/tags/for-upstream' into staging
 Date: Tue Nov 27 09:48:10 2018 +0000
    Signed-off-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.co=
m>
    Signed-off-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.co=
m>
ERROR: pull request includes tag with UTF-8 error in person name

Can you fix up and respin, please?

thanks
-- PMM
