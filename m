Received: from eggs.gnu.org ([2001:4830:134:3::10]:34071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDVb-0004PJ-Bz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDVa-0000vu-KE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:24:03 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etDVa-0000vO-FG
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:24:02 -0500
Received: by mail-ot0-x231.google.com with SMTP id t2so18485850otj.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:24:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 14:23:41 +0000
Message-ID: <CAFEAcA-s6Me4sjYPpjk5ZYw0cKVJVJ-PCnGVn1xxbD3VdkALZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/34] Misc patches for 2018-03-06
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

On 6 March 2018 at 13:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 58e2e17dba49b43f4ac9de19468aeae1c787dc=
c2:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-03-06 11:20:44 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3e015d815b3f28bfd874bf8a1697308ef9af2b4c:
>
>   use g_path_get_basename instead of basename (2018-03-06 14:01:29 +0100)
>
> ----------------------------------------------------------------
> * new QMP command qom-list-properties (Alexey)
> * TCG cleanups (David)
> * use g_path_get_basename/g_path_get_dirname when useful (Julia)
> * WHPX fixes (Justin)
> * ASAN fixes (Marc-Andr=C3=A9)
> * g364fb memory leak fix, address_space_to_flatview RCU fixes (me)
> * chardev memory leak fix (Peter)
> * checkpatch improvements (Julia, Su Hang)
> * next round of deprecation patches (Thomas)
>

Applied, thanks.

-- PMM
