Received: from eggs.gnu.org ([2001:4830:134:3::10]:40127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePunE-0001M7-S6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePunE-0003uP-3n
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:33:08 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:42985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePunD-0003tf-Vv
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:33:08 -0500
Received: by mail-ot0-x235.google.com with SMTP id i1so8549513oth.9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:33:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215170453.8922-1-berrange@redhat.com>
References: <20171215170453.8922-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 18:32:46 +0000
Message-ID: <CAFEAcA_vcQy9+Ym47NEzkXWMnekHhHi6qZ_ghYLGS4kAPhfsgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/1] Merge qio 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 December 2017 at 17:04, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 5705b536b597de00d82807bf14bb38f542aa4491:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171213' into staging (2017-12-14 14:22:18 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-201712151
>
> for you to fetch changes up to 530473924d57fd26ba9779c8702574db4df829d3:
>
>   io: introduce a network socket listener API (2017-12-15 15:07:26 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2017/12/15 v1
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>   io: introduce a network socket listener API
>
>  include/io/net-listener.h | 174 ++++++++++++++++++++++++++
>  io/Makefile.objs          |   1 +
>  io/net-listener.c         | 307 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 482 insertions(+)
>  create mode 100644 include/io/net-listener.h
>  create mode 100644 io/net-listener.c

Applied, thanks.

-- PMM
