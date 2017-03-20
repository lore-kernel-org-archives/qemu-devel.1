Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpuuR-0004F3-Kt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpuuQ-00017S-KL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:51:31 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpuuQ-00016z-Ea
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:51:30 -0400
Received: by mail-wm0-x233.google.com with SMTP id u132so59964854wmg.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:51:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
References: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 10:51:08 +0000
Message-ID: <CAFEAcA8PdEG-dNitq-c8gPsEQXCA=MfWfLHCsjOiVgO6-Jcixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] fixes: vnc, cirrus,
 tcg display updates.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 08:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Misc bugfixes for the next -rc.
>
> please pull,
>   Gerd
>
> The following changes since commit 272d7dee5951f926fad1911f2f072e5915cdcb=
a0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-cirrus-20170316-=
1' into staging (2017-03-16 16:40:44 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-fixes-20170320-1
>
> for you to fetch changes up to 7bc4f0846f5e15dad5a54490290241243b5a4416:
>
>   vnc: fix a qio-channel leak (2017-03-20 09:07:34 +0100)
>
> ----------------------------------------------------------------
> fixes for 2.9: vnc, cirrus, tcg display updates.
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       ui/console: ensure graphic updates don't race with TCG vCPUs
>
> Gerd Hoffmann (1):
>       cirrus: fix off-by-one in cirrus_bitblt_rop_bkwd_transp_*_16
>
> Marc-Andr=C3=A9 Lureau (1):
>       vnc: fix a qio-channel leak

Applied, thanks.

-- PMM
