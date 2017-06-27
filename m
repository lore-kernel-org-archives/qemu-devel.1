Received: from eggs.gnu.org ([2001:4830:134:3::10]:60702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPu0G-0006Zv-MZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPu0F-0007cC-Rz
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:16 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPu0F-0007bs-Jv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:15 -0400
Received: by mail-wm0-x234.google.com with SMTP id t129so7085901wmt.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 10:10:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:09:53 +0100
Message-ID: <CAFEAcA9OdsRnNfoRP+n16K_tqBR7XupcTtzYKayLeDA+gyji7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 27 June 2017 at 16:37, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Hi,
>
> Paolo suggested offline that we send a pull request for this series.
> Here it is, I've run it through my testsuite + tested the LQSPI testcase
> on Zynq.
>
> Cheers,
> Edgar
>
> ChangeLog:
>
> v1 -> v2:
> * Add EI RB line to patch #6
> * Remove changelogs from commit messages
> * Add EI SoB lines to all patches
>
>
> The following changes since commit 054914f6461ce9d3427af6527ef3e5b07311c86b:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-06-26 15:38:29 +0100)
>
> are available in the git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec-v2.for-upstream
>
> for you to fetch changes up to 252b99baeb9e7e86cc0ece8efcaddebf11d284f5:
>
>   xilinx_spips: allow mmio execution (2017-06-27 15:09:15 +0200)
>
> ----------------------------------------------------------------
> edgar/mmio-exec-v2.for-upstream
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
