Received: from eggs.gnu.org ([2001:4830:134:3::10]:60438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMOfc-0005hv-7d
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 19:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMOfb-0007va-FD
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 19:34:12 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:35609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMOfb-0007vK-Ag
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 19:34:11 -0500
Received: by mail-vk0-x232.google.com with SMTP id y197so78007463vky.2
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 16:34:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
References: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Dec 2016 00:33:48 +0000
Message-ID: <CAFEAcA-E+O_L71sAVdxoJHvwQCGMSzB6xBvb0yQO0dJNM1dYyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/12] M68k for 2.9 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 December 2016 at 17:53, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit e5fdf663cf01f824f0e29701551a2c29554d80a4:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20161223' into staging (2016-12-27 14:56:47 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request
>
> for you to fetch changes up to 2b5e2170678af36df48ab4b05dff81fe40b41a65:
>
>   target-m68k: free TCG variables that are not (2016-12-27 18:28:40 +0100)
>
> ----------------------------------------------------------------
> A series of patches queued since the beginning of the freeze period.
> Compared to the m68k-for-2.9 branch, 3 patches implementing bitfield
> ops are missing as they need new TCG functions. They will be pushed
> later.
> v2: remove warning for unused variables.
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
