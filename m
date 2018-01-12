Received: from eggs.gnu.org ([2001:4830:134:3::10]:49518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2Oe-0007ig-Ea
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2Od-0002qu-LX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:41:36 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:39154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea2Od-0002qe-Fr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:41:35 -0500
Received: by mail-ot0-x232.google.com with SMTP id 37so5514308otv.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:41:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 16:41:14 +0000
Message-ID: <CAFEAcA8LvADssgJmP-eMsRN6JJn+pZUL9pmfV_D3mnQYY1wtJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Vnc 20180112 patches
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

On 12 January 2018 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vnc-20180112-pull-request
>
> for you to fetch changes up to 30b80fd5269257f55203b7072c505b4ebaab5115:
>
>   ui: mix misleading comments & return types of VNC I/O helper methods (2018-01-12 13:48:54 +0100)
>
> ----------------------------------------------------------------
> vnc: limit memory usage (CVE-2017-15124)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
