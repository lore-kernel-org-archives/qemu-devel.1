Received: from eggs.gnu.org ([2001:4830:134:3::10]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHPC-0004gN-GY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHP7-0002zG-OI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:12:54 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpHP7-0002yQ-Hy
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:12:49 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k20so1177556wre.4
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:12:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905160027.15081-1-groug@kaod.org>
References: <20170905160027.15081-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:12:28 +0100
Message-ID: <CAFEAcA9mynRtf6emrHy9=K12nfTxv51HDo+03K-5E9faQMbirA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/4] 9pfs/virtfs patches for 2.11 20170905
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 17:00, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 53e2c48d3f0db6a1598f49baf0b56dd4975e53=
a7:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-09-04 18:53:46 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 32b6943699948f7adc35ada233fbd25daffad5e9:
>
>   virtfs: error out gracefully when mandatory suboptions are missing (201=
7-09-05 17:56:58 +0200)
>
> ----------------------------------------------------------------
> Some trivial fixes/cleanup and a fix to cause QEMU to error out gracefull=
y
> instead of aborting.
>
> ----------------------------------------------------------------
> Greg Kurz (2):
>       9pfs: local: clarify fchmodat_nofollow() implementation
>       virtfs: error out gracefully when mandatory suboptions are missing
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       9pfs: avoid sign conversion error simplifying the code
>
> ZhiPeng Lu (1):
>       fsdev: fix memory leak in main()

Applied, thanks.

-- PMM
