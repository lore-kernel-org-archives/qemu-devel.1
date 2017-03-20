Received: from eggs.gnu.org ([2001:4830:134:3::10]:39644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0nQ-0001zi-KF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0nP-00080i-LK
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:08:40 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cq0nP-000801-FI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:08:39 -0400
Received: by mail-wm0-x22a.google.com with SMTP id n11so68846114wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 10:08:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320160446.14643-1-pbonzini@redhat.com>
References: <20170320160446.14643-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 17:08:17 +0000
Message-ID: <CAFEAcA996Oefsr0s4e1dKk_=96eNAFWYY+HNpiWtm8fZLCWMYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] Misc fixes for 2.9.0-rc1
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

On 20 March 2017 at 16:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit ebedf0f9cd46b617df331eecc857c379d574ac62:
>
>   nios2: iic: Convert CPU prop to qom link (2017-03-18 18:22:54 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b3d3a426da9b067366bc132d53a6fa6b72675b55:
>
>   hax: fix breakage in locking (2017-03-20 12:24:43 +0100)
>
> ----------------------------------------------------------------
> fixes for 2.9-rc1, plus removal of -mno-cygwin references
>
> ----------------------------------------------------------------
> Paolo Bonzini (2):
>       qemu-ga: obey LISTEN_PID when using systemd socket activation
>       configure: remove Cygwin
>
> Stefano Stabellini (1):
>       xen: do not build backends for targets that do not support xen
>
> Vincent Palatin (1):
>       hax: fix breakage in locking

Applied, thanks.

-- PMM
