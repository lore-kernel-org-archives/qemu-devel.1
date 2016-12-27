Received: from eggs.gnu.org ([2001:4830:134:3::10]:33210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLvZB-000518-2Q
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLvZ9-00031G-QN
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:29:37 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLvZ9-000319-M6
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:29:35 -0500
Received: by mail-ua0-x234.google.com with SMTP id v2so13028574uac.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 09:29:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
References: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 17:29:14 +0000
Message-ID: <CAFEAcA9VcFR1hPbn25mr7Wx5gwfQSV0N0AXPJrOVf-ib5ahQsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] cryptodev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 December 2016 at 06:12, Gonglei <arei.gonglei@huawei.com> wrote:
> The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)
>
> are available in the git repository at:
>
>
>   https://github.com/gongleiarei/qemu.git tags/cryptodev-next-20161224
>
> for you to fetch changes up to 48ae36c0ad16bb757d4f6e243b8e9072fc8e8c8e:
>
>   cryptodev: add 3des-ede support (2016-12-24 13:46:27 +0800)
>
> ----------------------------------------------------------------
> - add xts mode support
> - add 3DES algorithm support
> - other trivial fixes
>
> ----------------------------------------------------------------
> Longpeng(Mike) (4):
>       cryptodev: fix the check of aes algorithm
>       cryptodev: add xts(aes) support
>       cryptodev: remove single-DES support in cryptodev
>       cryptodev: add 3des-ede support
>
>  backends/cryptodev-builtin.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 15 deletions(-)

Hi. This pull request does not appear to be signed by the GPG
key that I have on record for you, and the key it is signed
by seems to be only self-signed and not signed by anybody
else...

thanks
-- PMM
