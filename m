Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIBkd-0000Dd-VA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIBkd-00034h-5F
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:07:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIBkc-000341-Vz
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:07:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id v198-v6so13597864oif.2
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 05:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 12:06:41 +0000
Message-ID: <CAFEAcA_GJEV1jLJxEOYrixA6hVLyQm-z-u0vq7HZL8a4xnqrcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Misc patches for 2018-10-30
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

On 30 October 2018 at 19:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2e14019d2a37f32ccecd786d8be4e9a70094e7f7:
>
>   lsi53c895a: check message length value is valid (2018-10-30 20:46:25 +0=
100)
>
> Already all bugfixes except for a single patch by Vitaly.
>
> ----------------------------------------------------------------
> * icount fix (Clement)
> * dumping fixes for non-volatile memory (Marc-Andr=C3=A9, myself)
> * x86 emulation fix (Rudolf)
> * recent Hyper-V CPUID flag (Vitaly)
> * Q35 doc fix (Daniel)
> * lsi fix (Prasad)
>
> ----------------------------------------------------------------

Signed-off-by: Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com>
ERROR: pull request includes tag with UTF-8 error in person name

In this case it looks like the commit has a signed-off-by
line with the correct encoding as well as the mangled one,
so you can just drop the mangled line.

thanks
-- PMM
